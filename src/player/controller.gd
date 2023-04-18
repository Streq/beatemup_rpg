extends Node

export var disabled = false
func _physics_process(delta: float) -> void:
	if disabled:
		return
	var input_state = get_parent().input_state
	input_state.copy_from(Controller.input_state)

