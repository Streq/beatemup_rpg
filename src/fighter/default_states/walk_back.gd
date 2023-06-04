extends CharacterState

func _physics_update(delta: float):
	root.velocity.x = move_toward(
		root.velocity.x, 
		root.speed*-root.facing_dir, 
		root.horizontal_acceleration * delta
	)
	var input = root.input_state
	var dir = input.dir
	#TODO MAKE THESE STATE TRANSITIONS
	if !dir.x:
		goto("idle")
		return
	elif root.facing_dir == sign(dir.x):
		goto("walk")
		return
	elif !input.A.is_pressed():
		goto("turn")
