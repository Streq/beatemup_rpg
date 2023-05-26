extends Control
tool
export var max_value := 4

export var progress := 0 setget set_progress
onready var sprite = $Sprite

func set_progress(val):
	progress = clamp(val,0,max_value)
	if sprite:
		sprite.frame = val

func fill():
	set_progress(max_value)
func empty():
	set_progress(0)
