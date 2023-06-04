extends CharacterState

func _physics_update(delta: float):
	var dir = root.input_state.dir
	
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*dir.x, 
		root.horizontal_acceleration * delta
	)

	if !dir.x:
		goto("idle_no_turn")
		return

