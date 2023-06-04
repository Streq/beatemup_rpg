extends CharacterState

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		root.horizontal_decceleration * delta
	)
	
	var dir = root.input_state.dir
	#TODO MAKE THESE STATE TRANSITIONS
	if dir.x:
		if root.facing_dir == sign(dir.x):
			goto("walk")
			return
		elif root.input_state.A.is_pressed():
			goto("walk_back")
		else:
			goto("turn")
			return
