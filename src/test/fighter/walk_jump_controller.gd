extends Node2D


func _physics_process(delta: float) -> void:
	var input = get_parent().input_state
	input.clear()
	input.dir.x = get_parent().facing_dir
	input.dir.y = -1
