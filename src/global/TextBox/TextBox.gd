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
func auto_adjust_position():
	var player :CanvasItem = Group.get_one("player")
	if player:
		var v_pos = player.get_global_transform_with_canvas().get_origin().y
		var v_center = player.get_viewport_rect().size.y/2.0
		if v_pos > v_center :
			move_to_top()
		else:
			move_to_bottom()


func _set_display_name(display_name:String):
	if display_name:
		name_label.text = " "+display_name+" "
	else:
		name_label.text = ""

func _ready():
	move_to_bottom()
	hide()


var text_queue = []


func _process(delta: float) -> void:
	pass

func text(name:String, text: String):
	name = name.strip_edges()
	text = text.strip_edges()
	if !text:
		return
	var msg = Message.new(name, text)
	
	text_queue.append(msg)
	if !displaying:
		_display()
	

var displaying := false

func _display():
	_set_display_name(text_queue[0].name)
	_reset_labels_text()
	_hide_arrow()
	displaying = true
	pause_client.pause()
	yield(get_tree().create_timer(0.1), "timeout")
	show()
	
	while !text_queue.empty():
		yield(_display_text(text_queue.pop_front()), "completed")
	
	yield(get_tree(),"idle_frame")
	hide()
	displaying = false
	pause_client.unpause()
	emit_signal("finished")
	

func _display_text(message: Message):
	_set_display_name(message.name)
	var text = message.text
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

		yield(get_tree().create_timer(0.3), "timeout")
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
var fast_chars_per_frame = 10
var normal_chars_per_frame = 3
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
	
	#prevents error when yielding for this function to complete
	#in case the other yield above never fires
	yield(get_tree().create_timer(0.0), "timeout")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A") or event.is_action_pressed("B"):
		emit_signal("next")


onready var arrow_animation: AnimationPlayer = $"%arrow_animation"


func _show_arrow():
	arrow_animation.play("blink")


func _hide_arrow():
	arrow_animation.play("hide")

class Message:
	var name:=""
	var text:=""
	func _init(_name, _text):
		name = _name
		text = _text
