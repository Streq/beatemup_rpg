extends Node


func move(body: KinematicBody2D):
	var old_pos = body.global_position
	body.velocity = body.move_and_slide_with_snap(
		body.velocity, Vector2(0, 8), Vector2.UP, true
	)
	if !body.is_on_floor():
		body.global_position = old_pos
		body.velocity = Vector2()
