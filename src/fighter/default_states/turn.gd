extends CharacterState

func _enter(params):
	pass

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		root.horizontal_decceleration * delta
	)
func _on_animation_finished(name):
	root.facing_dir = -root.facing_dir
	._on_animation_finished(name)
