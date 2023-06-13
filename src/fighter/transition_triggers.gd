extends Node

export var state_machine_path : NodePath
onready var state_machine : StateMachine = get_node(state_machine_path) as StateMachine

onready var transitions = get_children()

var state_transitions_map = {}

func _ready() -> void:
	yield(state_machine,"initialized")
	refresh_transition_map()

func refresh_transition_map():
	state_transitions_map = {}
	for t in transitions:
		var transition : Transition = t
		for state_from in transition.get_states_from(state_machine.states.keys()):
			add_to_map(state_from, transition)


func add_to_map(state_from, transition):
	if !state_transitions_map.has(state_from):
		state_transitions_map[state_from] = []
	state_transitions_map[state_from].append(transition)


func find_first_transition_match():
	var state_from = owner.state_machine.current.name
	if !state_transitions_map.has(state_from):
		return null
	var state_transitions = state_transitions_map[state_from]
#	if owner.name == "pelado":
#		print("CHEQUEANDO JUGADOR")
	for transition in state_transitions:
#		print("checking:",transition.name)
		if transition.conditions_match():
			return transition.state_to
	return null

func _physics_process(delta: float) -> void:
	var transition = find_first_transition_match()
	if transition:
		var current = owner.state_machine.current
		if current.name != transition:
			current.goto(transition)
