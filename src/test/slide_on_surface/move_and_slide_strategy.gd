extends Node


func move(body: KinematicBody2D):
	body.velocity = body.move_and_slide(body.velocity, Vector2.UP, true)
