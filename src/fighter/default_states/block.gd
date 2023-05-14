extends CharacterState

func _physics_update(delta: float):
	var acceleration = (
		root.horizontal_decceleration
		if root.is_on_floor() else
		root.horizontal_air_decceleration
	)
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		acceleration * delta
	)
	
#	var dir = root.input_state.dir
#	var dirx =  sign(dir.x)
#	if root.is_on_floor() and dirx and dirx != sign(root.facing_dir):
#		root.velocity = Vector2(dirx*100.0,-50.0)
		
