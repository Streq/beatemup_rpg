extends CharacterState

func _physics_update(delta: float):
	var acceleration = (
		root.horizontal_decceleration
		if root.is_on_floor() else
		root.horizontal_air_decceleration
	)
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		acceleration * delta
	)
	var A = root.input_state.A
	if root.input_state.B.is_just_pressed():
		goto("jab")
		return
	
	if !A.is_pressed():
		goto("idle")
		return
