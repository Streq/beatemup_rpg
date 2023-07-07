extends Node

export var disabled := false

func disable():
	disabled = true
func enable():
	disabled = false
	
func get_dir():
	if disabled:
		return Vector2()
	return Input.get_vector("left2","right2","up2","down2")

func get_interact():
	if disabled:
		return false
	return false
