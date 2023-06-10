extends Node


export var dir := Vector2()
export var just_pressed := false


onready var input_state : InputState = get_node("%input_state")



func check():
	return (
		(
			!dir.x or 
			(
				just_pressed and 
				input_state.is_x_just_pressed(dir.x*owner.facing_dir)
			) or
			(
				!just_pressed and 
				sign(input_state.dir.x*owner.facing_dir) == sign(dir.x)
			)
		) and
		(
			!dir.y or 
			(
				just_pressed and 
				input_state.is_y_just_pressed(dir.y)
			) or
			(
				!just_pressed and 
				sign(input_state.dir.y) == sign(dir.y)
			)
		)
		
	)
