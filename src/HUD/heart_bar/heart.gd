extends Control
tool
export var max_value := 4

export var progress := 0 setget set_progress
export var capacity := 4 setget set_capacity
onready var sprite = $Sprite

func set_progress(val):
	progress = clamp(val,0,capacity)
	if sprite:
		sprite.frame_coords.x = val

func fill():
	set_progress(max_value)

func empty():
	set_progress(0)

func set_capacity(val):
	capacity = clamp(val, 0, max_value)
	if sprite:
		sprite.frame_coords.y = val
