extends Node
class_name Transition

export (PoolStringArray) var accept_regex_states_from
export (PoolStringArray) var reject_regex_states_from

onready var matcher = RegexMatcher.new(accept_regex_states_from, reject_regex_states_from)

export var state_to : String

export var disabled := false

onready var fighter : Fighter = owner
onready var conditions = get_children()


func conditions_match():
	if disabled:
		return false
	for condition in conditions:
		if !condition.check():
			return false
	return true

func get_states_from(state_list)->Array:
	var ret = []
	for state in state_list:
		if matcher.check(state):
			ret.append(state)
	return ret

