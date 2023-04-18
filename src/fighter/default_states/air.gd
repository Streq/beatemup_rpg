extends CharacterState

func _physics_update(delta: float):
	if root.is_on_floor():
		goto("idle")
	
	
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
	
