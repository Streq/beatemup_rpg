extends Node

export var value := -1 setget set_value

func set_value(val):
	value = val
	if val >= 0:
		Engine.target_fps = val
		Engine.time_scale = val/60.0
		Engine.iterations_per_second = val

func _physics_process(delta):
	set_value(60)
	if Input.is_action_pressed("speed_up"):
		set_value(144)
	
	if Input.is_action_pressed("speed_down"):
		set_value(15)
