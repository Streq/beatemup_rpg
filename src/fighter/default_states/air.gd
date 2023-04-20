extends CharacterState

func _physics_update(delta: float):
	if root.is_on_floor():
		goto("idle")
	
	if root.input_state.B.is_just_pressed():
		goto("jab")
		return
	
	if root.input_state.A.is_pressed():
		goto("block")
		return
	
	
	var dir = root.input_state.dir
	var acceleration = (
		root.horizontal_air_acceleration 
		if dir.x else 
		root.horizontal_air_decceleration
	)
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*dir.x, 
		acceleration * delta
	)
