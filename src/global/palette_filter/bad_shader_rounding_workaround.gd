extends Node
tool

func _ready() -> void:
	for i in 4:
		get_parent().palette[i].b = i/255.0
	if !Engine.editor_hint:
		queue_free()
