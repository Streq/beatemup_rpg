extends Node

onready var conditions = get_children()

func check():
	for condition in conditions:
		if !condition.check():
			return false
	return true
