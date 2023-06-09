extends CharacterState

func _physics_update(delta: float):
	var input = root.input_state
	var dir = input.dir
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*dir.x, 
		root.horizontal_acceleration * delta
	)
	#TODO MAKE THESE STATE TRANSITIONS
	if !dir.x:
		goto("idle")
		return
	elif !input.A.is_pressed():
		if root.facing_dir == sign(dir.x):
			goto("walk")
			return
		else:
			goto("turn")
			return
