extends Node


func move(body: KinematicBody2D):
	var old_pos = body.global_position
	var velocity = body.velocity
	body.move_and_slide(Vector2(),Vector2.UP)
	body.grounded = body.is_on_floor()
	
	body.velocity = body.move_and_slide_with_snap(
		body.velocity, Vector2(0, 8), Vector2.UP, true
	)
	if !body.is_on_floor() and body.grounded:
		body.global_position = old_pos - Vector2(sign(velocity.x)*0,0)
		body.grounded = true
		body.velocity = Vector2()
