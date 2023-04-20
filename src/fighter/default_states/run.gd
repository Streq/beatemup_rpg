extends CharacterState

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*root.facing_dir, 
		root.horizontal_acceleration * delta
	)
	
	
	if root.input_state.B.is_just_pressed():
		goto("jab")
		return
	if root.input_state.A.is_pressed():
		goto("block")
		return
	
	if !root.is_on_floor():
		goto("air")
		return
	var dir = root.input_state.dir
	
	if dir.y < 0.0:
		root.jump()
	if !dir.x:
		goto("idle")
		return
	else:
		root.facing_dir = dir.x
