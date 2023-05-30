extends Node
tool

func _ready() -> void:
	for i in 4:
		get_parent().palette[i].b = round(get_parent().palette[i].b*255.0)/255.0
	if !Engine.editor_hint:
		queue_free()
