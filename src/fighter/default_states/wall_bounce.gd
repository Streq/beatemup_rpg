extends CharacterState

export var DURATION_FRAMES := 15

var frames := 0

func _enter(params):
	frames = 0

func _physics_update(delta: float):
	if frames >= DURATION_FRAMES:
		goto("air")
		return
	frames += 1
	root.velocity.y = 0.0

	if root.input_state.is_y_just_pressed(-1):
#		root.facing_dir = root.input_state.dir.x
		goto("wall_jump")
		return
		
	if root.input_state.is_y_just_pressed(1):
		goto("air")
		return
