extends CharacterState

export var delay := 0.1

var current_delay := 0.0

func _enter(params):
	current_delay = delay
	pass

func _physics_update(delta: float):
	if current_delay <= 0:
		root.jump()
		goto("air")
		return
	
	
	current_delay -= delta
	
