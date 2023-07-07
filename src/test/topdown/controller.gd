extends Node
export var disabled := false
func disable():
	disabled = true
func enable():
	disabled = false


func get_dir():
	if disabled:
		return Vector2()
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
func get_interact():
	if disabled:
		return false
	return Input.is_action_just_pressed("A")

