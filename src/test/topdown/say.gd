extends Node

export var text_name := ""
export (String, MULTILINE) var text := ""

func _ready() -> void:
	get_parent().connect("interacted_with",self,"trigger")
func trigger(who):
	get_parent().face_toward(who)
	TextBox.text(text_name,text)
