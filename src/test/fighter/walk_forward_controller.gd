extends Node2D

var just_turned = false

func _physics_process(delta: float) -> void:
	var input = get_parent().input_state
	input.dir.x = get_parent().facing_dir
	if get_parent().is_on_wall() and !just_turned:
		input.dir.x = -input.dir.x
		just_turned = true
		for i in 3:
			yield(get_tree(),"physics_frame")
		just_turned = false
