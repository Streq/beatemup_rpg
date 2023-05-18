extends Node
export var animation_backwards := "air_jump_spin_backwards"
export var animation_forward := "air_jump_spin"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect("pre_enter",self,"set_animation")


func set_animation():
	var dirx = owner.input_state.dir.x
	if !dirx:
		dirx = owner.velocity.x
	if (
		!dirx or 
		sign(dirx) == sign(owner.facing_dir)
	):
		get_parent().animation = animation_forward
	else:
		get_parent().animation = animation_backwards
