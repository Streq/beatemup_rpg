extends Node


func get_dir():
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
