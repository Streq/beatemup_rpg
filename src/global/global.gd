extends Node

func _ready() -> void:
	OS.min_window_size=Vector2(
		ProjectSettings.get("display/window/size/width"),
		ProjectSettings.get("display/window/size/height")
	)
