extends CharacterState

func _physics_update(delta: float):
	var dir = root.input_state.dir
	var acceleration = (
		root.horizontal_air_acceleration 
		if dir.x else 
		root.horizontal_air_decceleration
	)
	
	if dir.y>0 and root.velocity.y>-25.0:
		root.velocity.y = root.fast_fall_speed
	
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*sign(dir.x), 
		acceleration * delta
	)
