extends CharacterState

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		root.horizontal_decceleration * delta
	)
	if !root.is_on_floor():
		goto("air")
		return
	var dir = root.input_state.dir
	if dir.y < 0.0:
		root.jump()
	if dir.x:
		root.facing_dir = dir.x
		goto("run")
		return
	
