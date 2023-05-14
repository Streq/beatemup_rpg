extends CharacterState


func _enter(params):
	var bump = -root.jump_speed*0.75
#	root.velocity.y = min(0, root.velocity.y)+bump
#	root.velocity.y = max(min(0, root.velocity.y)+bump,-root.jump_speed)
	root.velocity.y = bump
	root.available_air_jumps -= 1


func _physics_update(delta: float):
	var input_state = root.input_state
	var dir = input_state.dir
	var acceleration = (
		root.horizontal_air_acceleration 
		if dir.x else 
		root.horizontal_air_decceleration
	)

	
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*sign(dir.x), 
		acceleration * delta
	)
