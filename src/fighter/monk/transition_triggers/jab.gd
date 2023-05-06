extends Node
class_name Transition

export (PoolStringArray) var accept_regex_states_from
export (PoolStringArray) var reject_regex_states_from

onready var matcher = RegexMatcher.new(accept_regex_states_from, reject_regex_states_from)

export var state_to : String

onready var fighter : Fighter = owner
onready var conditions = $conditions


func conditions_match():
	if !is_instance_valid(conditions):
		return false
	return conditions.check()

func get_states_from(state_list)->Array:
	var ret = []
	for state in state_list:
		if matcher.check(state):
			ret.append(state)
	return ret

