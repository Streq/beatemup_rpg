extends Node


func _ready() -> void:
	for i in 4:
		get_parent().palette[i].b = i/255.0
	queue_free()
