extends Node


export var dir := Vector2()
export var just_pressed := false


onready var input_state : InputState = get_node("%input_state")

func check():
	return (
		(!dir.x or input_state.is_x_just_pressed(dir.x*owner.facing_dir)) and
		(!dir.y or input_state.is_y_just_pressed(dir.y))
	)
