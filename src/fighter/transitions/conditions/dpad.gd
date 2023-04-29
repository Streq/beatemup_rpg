extends Node


export var dir := Vector2()
export var just_pressed := false


onready var input_state : InputState = get_node("%input_state")

func check():
	return (
		(!dir.x or sign(dir.x) == sign(input_state.dir.x)) and
		(!dir.y or sign(dir.y) == sign(input_state.dir.y))
	)
