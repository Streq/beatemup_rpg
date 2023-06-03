extends Node


func step(amount:float):
	owner.velocity.x += amount*owner.facing_dir

func stop():
	owner.velocity.x = 0
