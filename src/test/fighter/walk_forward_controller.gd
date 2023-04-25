extends Node2D


func _physics_process(delta: float) -> void:
	var input = get_parent().input_state
	input.dir.x = get_parent().facing_dir
	
