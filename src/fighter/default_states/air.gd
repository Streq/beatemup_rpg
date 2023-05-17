extends CharacterState

func _physics_update(delta: float):
	var input_state = root.input_state
	var dir = input_state.dir
	var velx = root.velocity.x
	var can_go_faster = sign(dir.x) != sign(velx) or root.speed > abs(root.velocity.x)
	
	var acceleration = (
		root.horizontal_air_acceleration 
		if dir.x and can_go_faster else 
		root.horizontal_air_decceleration
	)
	
	if input_state.is_y_just_pressed(1.0) and root.velocity.y>-25.0:
		root.velocity.y = root.fast_fall_speed
		goto("air_fast_fall")
		return
	if input_state.is_y_just_pressed(-1.0) and root.available_air_jumps:
		goto("air_jump")
		return
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*sign(dir.x), 
		acceleration * delta
	)
