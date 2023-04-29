extends Node

export var button := "A"
export var pressed := true
export var allow_hold := false

onready var input_state : InputState = get_node("%input_state")

func check():
	var b = input_state.get(button)
	return b.pressed == pressed and (allow_hold or b.just_updated)
