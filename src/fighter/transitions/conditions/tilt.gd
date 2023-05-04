extends Node
export var button := "A"
export var dir := Vector2()
export var pressed := true
export var allow_hold := false

onready var input_state : InputState = get_node("%input_state")

func check():
	var b = input_state.get(button)
	return (
		b.pressed == pressed and (allow_hold or b.just_updated) and
		(!dir.x or sign(dir.x) == sign(input_state.dir.x)) and
		(!dir.y or sign(dir.y) == sign(input_state.dir.y))
	)

