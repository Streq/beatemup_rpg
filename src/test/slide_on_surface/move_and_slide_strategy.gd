extends Node

func move(body: KinematicBody2D):
	body.velocity = body.move_and_slide(body.velocity, Vector2.UP, true)
	body.grounded = body.is_on_floor()
