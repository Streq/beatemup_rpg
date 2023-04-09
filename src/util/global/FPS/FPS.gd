extends Node

export var value := -1 setget set_value

func set_value(val):
	value = val
	if val >= 0:
		Engine.target_fps = val

