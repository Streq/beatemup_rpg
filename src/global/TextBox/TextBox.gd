extends CanvasLayer
signal next
signal finished
onready var lines_container: VBoxContainer = $"%lines_container"

onready var arrow: TextureRect = $"%arrow"

onready var pause_client: Node = $"%pause_client"
onready var name_label: Label = $"%name"

onready var box: NinePatchRect = $"%box"
func move_to_top():
	box.set_anchors_and_margins_preset(Control.PRESET_TOP_WIDE)
	box.grow_vertical = Control.GROW_DIRECTION_END
func move_to_bottom():
	box.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_WIDE)
	box.grow_vertical = Control.GROW_DIRECTION_BEGIN

func set_display_name(display_name:String):
	if display_name:
		name_label.text = " "+display_name+" "
	else:
		name_label.text = ""
		
func _ready():
	move_to_bottom()
	hide()
	yield(_wait_for_input(), "completed")
	set_display_name("Gordo")
	text(
		"""Hola amigos de youtube yo soy santicapogaming pero pueden decirme santicapo. 
		Y vengo a enseñarles como instalar el sims 4 con crack.
		Yo no lo descargo porque ya lo tengo."""
	)
	yield(self, "finished")
	set_display_name("Capinho Jr")
	move_to_top()
	text("que puto que so")
	text("so putisimo")
	yield(self, "finished")
	move_to_bottom()
	set_display_name("Edgardo")
	text("cuchame fresco")
	yield(self, "finished")
	set_display_name("El Pibe")
	text("si que queres")
	yield(self, "finished")
	set_display_name("Edgardo")
	text("quiero a tu hermana boludo")
	
	yield(self, "finished")
	set_display_name("Jojo")
	move_to_top()
	text("cucha wachin")
	text("quiero flashear ser pabre")

	yield(self, "finished")
	set_display_name("")
	text("nada yo no soy nadie")

var text_queue = []


func _process(delta: float) -> void:
	if displaying:
		return
	if text_queue.empty():
		pause_client.unpause()
		emit_signal("finished")
		return
	_display_text(text_queue.pop_front())

func text(text: String):
	text = text.strip_edges()
	if !text:
		return
	text_queue.append(text)


var displaying := false


func _display_text(text: String):
	pause_client.pause()
	show()
	displaying = true
	var texts = text.split("\n", false)

	var line_labels = lines_container.get_children()
	var current_paragraph = -1
	for paragraph in texts:
		current_paragraph += 1
		_set_word_source(paragraph)

		line_index = 0
		shown_lines = 0
		_hide_arrow()
		_reset_labels_text()

		yield(get_tree().create_timer(0.1), "timeout")
		if !_has_next_word():
			continue

		line_labels[0].text = _get_next_word()

		while _has_next_word():
			if _next_word_overflows_line():
				line_index += 1
				if line_index >= max_lines:
					yield(_show_characters_one_by_one(), "completed")

					_show_arrow()
					yield(_wait_for_input(), "completed")

					_hide_arrow()
					yield(_scroll_one_line(), "completed")

#			yield(_wait_for_input(), "completed")
			_add_word(line_labels[line_index], _get_next_word())

		yield(_show_characters_one_by_one(), "completed")
		if current_paragraph < texts.size() - 1:
			_show_arrow()
		yield(_wait_for_input(), "completed")
	hide()
	displaying = false


var words: PoolStringArray
var line_index := 0
onready var max_lines := lines_container.get_child_count()


func _set_word_source(paragraph: String):
	words = paragraph.split(" ", false)


func _reset_labels_text():
	for label in lines_container.get_children():
		label.text = ""


onready var scroll_animation: AnimationPlayer = $"%scroll_animation"
func _scroll_one_line():
	scroll_animation.play("scroll_one_line")
	line_index -= 1
	shown_lines -= 1
	yield(scroll_animation, "animation_finished")
	pass


func _new_line():
	var lines = lines_container.get_children()
	for i in lines.size() - 1:
		lines[i].text = lines[i + 1].text
	lines[-1].text = ""


func _has_next_word():
	return words.size() > 0


func _next_word_overflows_line() -> bool:
	var lines = lines_container.get_children()
	var line: Label = lines[line_index]
	var aux = line.text
	_add_word(line, words[0])
	var ret = line.get_line_count() > 1
	line.text = aux
	return ret


static func _add_word(label: Label, word: String) -> void:
	if label.text:
		label.text += " " + word
	else:
		label.text = word


func _get_next_word() -> String:
	var ret = words[0]
	words.remove(0)
	return ret


func _wait_for_input():
	yield(self, "next")


var shown_lines := 0
var characters_shown_since_last_frame := 0
var fast_chars_per_frame = 5
var normal_chars_per_frame = 1
var chars_per_frame = 0


func _refresh_chars_per_frame():
	chars_per_frame = (
		fast_chars_per_frame
		if Input.is_action_pressed("B") or Input.is_action_pressed("A")
		else normal_chars_per_frame
	)


func _show_characters_one_by_one():
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
		_refresh_chars_per_frame()
		for c in text:
			line.text += c
			characters_shown_since_last_frame += 1
			if characters_shown_since_last_frame >= chars_per_frame:
				characters_shown_since_last_frame = 0
				yield(get_tree().create_timer(0.05), "timeout")
				_refresh_chars_per_frame()
		shown_lines += 1


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A") or event.is_action_pressed("B"):
		emit_signal("next")


onready var arrow_animation: AnimationPlayer = $"%arrow_animation"


func _show_arrow():
	arrow_animation.play("blink")


func _hide_arrow():
	arrow_animation.play("hide")
