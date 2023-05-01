extends CharacterState

export var delay := 0.1

var current_delay := 0.0
var jumped = false
func _enter(params):
	current_delay = delay
	jumped = false
	pass

func _physics_update(delta: float):
	if !root.is_on_floor():
		goto("air")
		return
	
	if current_delay <= 0:
		if !jumped:
			jumped = true
			root.jump()
			return
		else:
			goto("idle")
			return
	
	current_delay -= delta
	
