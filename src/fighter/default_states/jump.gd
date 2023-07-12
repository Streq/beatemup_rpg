extends CharacterState

export var delay := 0.1

var current_delay := 0.0
var accum_press := 0.0
var jumped = false
var holding_jump := false

export var failed_jump_state := "idle"

func _enter(params):
	current_delay = delay
	jumped = false
	holding_jump = true
	accum_press = 0.0
	pass

func _physics_update(delta: float):
	if current_delay <= 0:
		print(accum_press)
		if !jumped:
			jumped = true
			var modifier = 1.0
			if accum_press<delay:
				modifier = 0.75
			root.velocity.y = -root.jump_speed*modifier
			return
		else:
			goto(failed_jump_state)
			return
	holding_jump = holding_jump and root.input_state.A.is_pressed()
	if holding_jump:
		accum_press += delta
	current_delay -= delta
	
