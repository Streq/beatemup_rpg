extends Node


func step(amount:float):
	owner.velocity.x += amount*owner.facing_dir
