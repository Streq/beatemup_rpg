extends Node


func move(body: KinematicBody2D):
	body.velocity = body.move_and_slide_with_snap(
		body.velocity, Vector2(0, 8), Vector2.UP, true
	)
