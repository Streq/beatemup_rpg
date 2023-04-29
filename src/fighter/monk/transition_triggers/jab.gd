extends Node
class_name Transition

export (PoolStringArray) var states_from
export var state_to : String

onready var fighter : Fighter = owner
onready var conditions = $conditions


func conditions_match():
	if !is_instance_valid(conditions):
		return false
	return conditions.check()
