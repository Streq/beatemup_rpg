extends CharacterState

export var strike_state := "strike"
export var no_strike_state := "idle"

func _enter(params):
	if owner.input_state.B.is_just_pressed():
		on_finish_goto_state = strike_state
	else:
		on_finish_goto_state = no_strike_state
	owner.facing_dir = owner.input_state.dir.x

func _physics_update(delta: float):
	if owner.input_state.B.is_just_pressed():
		on_finish_goto_state = strike_state
	
	var acceleration = (
		root.horizontal_decceleration
		if root.grounded else
		root.horizontal_air_decceleration
	)
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		acceleration * delta
	)
