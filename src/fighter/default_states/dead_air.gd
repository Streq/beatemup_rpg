extends CharacterState

func _physics_update(delta: float):
	var acceleration = (
		root.horizontal_decceleration
		if root.grounded else
		root.horizontal_air_decceleration
	)
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		acceleration * delta
	)
	if root.grounded:
		goto("dead")
		return
