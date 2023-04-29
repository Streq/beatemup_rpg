extends Node

onready var transitions = get_children()

var state_transitions_map = {}

func _ready() -> void:
	refresh_transition_map()

func refresh_transition_map():
	state_transitions_map = {}
	for t in transitions:
		var transition : Transition = t
		for state_from in transition.states_from:
			if !state_transitions_map.has(state_from):
				state_transitions_map[state_from] = []
			state_transitions_map[state_from].append(transition)

func find_first_transition_match():
	var state_from = owner.state_machine.current.name
	if !state_transitions_map.has(state_from):
		return
	var state_transitions = state_transitions_map[state_from]
	for transition in state_transitions:
		if transition.conditions_match():
			return transition.state_to
	return null

func _physics_process(delta: float) -> void:
	var transition = find_first_transition_match()
	if transition:
		owner.state_machine.current.goto(transition)
