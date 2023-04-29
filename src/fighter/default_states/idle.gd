extends CharacterState

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		root.horizontal_decceleration * delta
	)
	
	var dir = root.input_state.dir
	if dir.x:
		root.facing_dir = dir.x
		goto("run")
		return
	
	
