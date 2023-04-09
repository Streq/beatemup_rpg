extends Node2D
tool
var map = {}
func _ready() -> void:
	for child in get_children():
		map[child.name] = child
		

func play(sound, position_2d):
	map[sound].play_at_position(position_2d)
