extends Node

func _ready() -> void:
	OS.min_window_size=Vector2(
		ProjectSettings.get("display/window/size/width"),
		ProjectSettings.get("display/window/size/height")
	)

func _input(event: InputEvent) -> void:
	var new_size = null
	if event.is_action_pressed("x1"):
		new_size = OS.min_window_size*1
	elif event.is_action_pressed("x2"):
		new_size = OS.min_window_size*2
	elif event.is_action_pressed("x3"):
		new_size = OS.min_window_size*3
	elif event.is_action_pressed("x4"):
		new_size = OS.min_window_size*4
	elif event.is_action_pressed("x5"):
		new_size = OS.min_window_size*5
	elif event.is_action_pressed("x6"):
		new_size = OS.min_window_size*6
	elif event.is_action_pressed("x7"):
		new_size = OS.min_window_size*7
	else:
		return
	if new_size:
		var old_position = OS.window_position
		var old_size = OS.window_size
		OS.window_size = new_size
		OS.window_position = old_position + (old_size-new_size)/2
	
