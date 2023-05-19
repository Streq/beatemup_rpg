extends Node

onready var input_state : InputState = get_node("%input_state")

export (float, -1.0, 1.0, 2.0) var side := 1.0


func check():
	var prev_vel_x = owner.previous_frame_velocity.x
	return (
		owner.is_on_wall() and
		sign(prev_vel_x) == sign(owner.facing_dir)*side and
		abs(prev_vel_x) > owner.speed
	)
