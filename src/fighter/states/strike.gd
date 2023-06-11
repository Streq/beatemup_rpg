extends CharacterState

export var strike_state := "strike"
export var no_strike_state := "idle"
export var decceleration_multiplier = 1.0
func _enter(params):
	if owner.input_state.B.is_just_pressed():
		on_finish_goto_state = strike_state
	else:
		on_finish_goto_state = no_strike_state

func _physics_update(delta: float):
	if owner.input_state.B.is_just_pressed():
		on_finish_goto_state = strike_state
	
	var acceleration = (
		root.horizontal_decceleration*decceleration_multiplier
		if root.grounded else
		root.horizontal_decceleration
	)
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		acceleration * delta
	)
	root.velocity.y = move_toward(
		root.velocity.y, 
		0, 
		acceleration * delta
	)
