extends CharacterState

func _enter(params) -> void:
	pass

#func _physics_update(delta: float):
#	root.velocity = Vector2()

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*0.75*root.facing_dir, 
		root.horizontal_acceleration * delta
	)
