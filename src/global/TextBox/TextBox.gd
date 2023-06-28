extends CanvasLayer
onready var label: Label = $"%label"
onready var label_margin: MarginContainer = $"%label_margin"
signal next()


func display_text(text: String):
	label.text

func _ready() -> void:
	var text = label.text
	label.text = ""
	print(label.get_line_count())
	print(label.get_visible_line_count())
	
	var index = 0
	var words = text.split(" ")
	label.visible_characters = 0
	while index < words.size():
		while label.get_line_count() - label.lines_skipped < 3 and index < words.size():
			label.text += words[index]
			index += 1
			label.text += " "
		#remove last word
		#TODO
		
		while label.visible_characters < label.get_total_character_count():
			print(label.visible_characters)
			label.visible_characters += 3
			yield(get_tree().create_timer(0.1),"timeout")
		yield(self, "next")
		yield(scroll(),"completed")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		emit_signal("next")

func scroll():
	label_margin.rect_position.y = 8
	yield(get_tree().create_timer(0.1),"timeout")
	label_margin.rect_position.y = 16
	label.lines_skipped += 1
	yield(get_tree().create_timer(0.1),"timeout")


#class WordFindResult:
#	var position : int = 0
#	var word : String = ""
#	func _init(_word,_position):
#		word = _word
#		position = _position
#func get_word(text: String, index: int) -> WordFindResult:
#	var first_space = text.find(" ", index)
#	var second_space = text.find(" ", first_space)
#	var word = text.substr(first_space + 1, first_space + second_space)
#	return WordFindResult.new(word, first_space+1)
