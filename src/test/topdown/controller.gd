extends Node


func get_dir():
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
func get_interact():
	return Input.is_action_just_pressed("A")
