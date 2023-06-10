extends CharacterState

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*root.facing_dir, 
		root.horizontal_acceleration * delta
	)
