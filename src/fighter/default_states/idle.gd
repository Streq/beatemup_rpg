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
	var x_dir  = root.input_state.dir.x
	if x_dir:
		root.facing_dir = x_dir
		goto("run")
		return
	
