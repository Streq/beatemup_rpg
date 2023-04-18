extends CharacterState

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*root.facing_dir, 
		root.horizontal_acceleration * delta
	)


	if !root.is_on_floor():
		goto("air")
		return
	
	var x_dir = root.input_state.dir.x
	
	if !x_dir:
		goto("idle")
		return
	else:
		root.facing_dir = x_dir
