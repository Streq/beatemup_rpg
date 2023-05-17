extends CharacterState

var global_ledge_position := Vector2()
onready var ledge_grab_point := $"%ledge_grab_point"
onready var ledge_detect: Node2D = $"%ledge_detect"

func _enter(params):
	global_ledge_position = ledge_detect.ledge
	root.refill_air_jumps()

func get_position_relative_to_ledge_grab():
	return ledge_grab_point.global_position-root.global_position

func _physics_update(delta: float):
	var position_relative_to_ledge_grab_point = get_position_relative_to_ledge_grab()
	root.global_position = global_ledge_position-position_relative_to_ledge_grab_point
	root.velocity = Vector2()
	if root.input_state.is_y_just_pressed(-1):
		root.facing_dir = root.input_state.dir.x
		goto("air_jump")
		return
	if root.input_state.dir.y>0:
		goto("air")
		return
