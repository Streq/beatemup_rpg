extends Node2D

var just_turned = false
var dir := 1.0

func _ready() -> void:
	dir = get_parent().facing_dir

func _physics_process(delta: float) -> void:
	var input = get_parent().input_state
	input.dir.x = dir
	
	if get_parent().is_on_wall():
		if !just_turned:
			dir = -dir
		just_turned =  true
	else:
		just_turned = false
#		just_turned and is_equal_approx(get_parent().velocity.x,0.0)
	
