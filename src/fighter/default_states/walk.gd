extends CharacterState

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.run_speed*root.facing_dir, 
		root.horizontal_acceleration * delta
	)

	var dir = root.input_state.dir
	if !dir.x:
		goto("idle")
		return
	elif root.facing_dir != sign(dir.x):
		goto("turn")
		return
