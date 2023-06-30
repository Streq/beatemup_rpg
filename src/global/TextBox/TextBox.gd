extends CanvasLayer

onready var lines_container: VBoxContainer = $"%lines_container"

onready var arrow: TextureRect = $"%arrow"

signal next


func _ready():
	yield(wait_for_input(), "completed")
	display_text(
		"""Hola amigos de youtube yo soy santi requena pero pueden decirme santicapo. 
		Y vengo a enseñarles como instalar el sims 4 con crack.
		Lo primero que tienen que hacer es ser muy buenos jugando al sims hermano. 
		Es asi, que queres que te diga.""" 
	)


func display_text(text: String):
	var texts = text.split("\n", false)

	var line_labels = lines_container.get_children()
	var current_paragraph = -1
	for paragraph in texts:
		current_paragraph += 1
		set_word_source(paragraph)
		
		line_index = 0
		shown_lines = 0
		hide_arrow()
		reset_labels_text()
		
		if !has_next_word():
			continue

		line_labels[0].text = get_next_word()

		while has_next_word():
			if next_word_overflows_line():
				line_index += 1
				if line_index >= max_lines:
					yield(show_characters_one_by_one(), "completed")

					show_arrow()
					yield(wait_for_input(), "completed")

					hide_arrow()
					yield(scroll_one_line(), "completed")
			
#			yield(wait_for_input(), "completed")
			add_word(line_labels[line_index], get_next_word())

		yield(show_characters_one_by_one(), "completed")
		if current_paragraph < texts.size()-1:
			show_arrow()
		yield(wait_for_input(), "completed")
		hide_arrow()


var words: PoolStringArray
var line_index := 0
onready var max_lines := lines_container.get_child_count()


func set_word_source(paragraph: String):
	words = paragraph.split(" ", false)


func reset_labels_text():
	for label in lines_container.get_children():
		label.text = ""


onready var animation_player: AnimationPlayer = $"%AnimationPlayer"


func scroll_one_line():
	animation_player.play("scroll_one_line")
	line_index -= 1
	shown_lines -= 1
	yield(animation_player, "animation_finished")
	pass


func new_line():
	var lines = lines_container.get_children()
	for i in lines.size() - 1:
		lines[i].text = lines[i + 1].text
	lines[-1].text = ""


func has_next_word():
	return words.size() > 0


func next_word_overflows_line() -> bool:
	var lines = lines_container.get_children()
	var line: Label = lines[line_index]
	var aux = line.text
	add_word(line, words[0])
	var ret = line.get_line_count() > 1
	line.text = aux
	return ret

static func add_word(label: Label, word: String) -> void:
	if label.text:
		label.text += " " + word
	else:
		label.text = word

func get_next_word() -> String:
	var ret = words[0]
	words.remove(0)
	return ret


func wait_for_input():
	yield(self, "next")

var shown_lines := 0
var characters_shown_since_last_frame := 0
func show_characters_one_by_one():
	var aux = []
	
	var lines = lines_container.get_children()
	aux.resize(lines.size())
	
	for i in range(shown_lines, lines.size()):
		var line = lines[i]
		aux[i] = line.text
		line.text = ""
	for i in range(shown_lines, lines.size()):
		var text = aux[i]
		var line = lines[i]
		for c in text:
			line.text += c
			characters_shown_since_last_frame += 1
			if characters_shown_since_last_frame >= 3:
				characters_shown_since_last_frame = 0
				yield(get_tree().create_timer(0.05), "timeout")
		shown_lines += 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		emit_signal("next")
		

onready var arrow_animation: AnimationPlayer = $"%arrow_animation"
func show_arrow():
	arrow_animation.play("blink")
func hide_arrow():
	arrow_animation.play("hide")
