extends CanvasLayer

onready var lines_container: VBoxContainer = $"%lines_container"

onready var arrow: TextureRect = $"%arrow"

signal next


func _ready():
	yield(wait_for_input(), "completed")
	display_text("hola amigos de youtube yo soy santi requena pero pueden decirme santicapo y vengo a enseñarles como instalar el sims 4 con crack")
#	scroll_one_line()


func display_text(text:String):
	var texts = text.split("\n", false)

	var line_labels = lines_container.get_children()

	for paragraph in texts:
		line_index = 0
		reset_labels_text()
		set_word_source(paragraph)

		if !has_next_word():
			continue
		
		line_labels[0].text = get_next_word()

		while has_next_word():
			if next_word_overflows_line():
				line_index += 1
				if line_index >= max_lines:
					yield(show_characters_one_by_one(), "completed")
			
					arrow.show()
					yield(wait_for_input(), "completed")

					arrow.hide()
					yield(scroll_one_line(), "completed")
				
			line_labels[line_index].text += " " + get_next_word()

		yield(show_characters_one_by_one(), "completed")
		yield(wait_for_input(), "completed")


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
	yield(animation_player, "animation_finished")
	line_index-=1
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
	var line : Label = lines[line_index]
	var aux = line.text
	line.text += words[0]
	var ret = (line.get_line_count() > 1)
	line.text = aux
	return ret


func get_next_word() -> String:
	var ret = words[0]
	words.remove(0)
	return ret


func wait_for_input():
	yield(self, "next")


func show_characters_one_by_one():
	var aux = []
	var lines = lines_container.get_children()
	for line in lines:
		aux.append(line.text)
		line.text = ""
	for i in aux.size():
		var text = aux[i]
		var line = lines[i]
		for c in text:
			yield(get_tree().create_timer(0.05), "timeout")
			line.text += c
			
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		emit_signal("next")
