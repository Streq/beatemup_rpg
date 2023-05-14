extends CharacterState

func _enter(params):
	root.velocity = Vector2(-root.facing_dir*100.0,-40.0)

func _physics_update(delta: float):
	var input_state = root.input_state
#	var dir = input_state.dir
#	var acceleration = (
#		root.horizontal_air_acceleration 
#		if dir.x else 
#		root.horizontal_air_decceleration
#	)
	
	if input_state.is_y_just_pressed(1.0) and root.velocity.y>-25.0:
		root.velocity.y = root.fast_fall_speed
		goto("air_fast_fall")
		return
	if input_state.is_y_just_pressed(-1.0) and root.available_air_jumps:
		goto("air_jump")
		return
	
#	root.velocity.x = move_toward(
#		root.velocity.x, 
#		root.speed*sign(dir.x), 
#		acceleration * delta
#	)
