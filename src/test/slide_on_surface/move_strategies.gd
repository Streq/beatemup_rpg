extends Node
var map = {}

func _ready() -> void:
	for child in get_children():
		map[child.name] = child
