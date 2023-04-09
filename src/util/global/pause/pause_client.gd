extends Node


export (PauseState.Level) var paused_at_level := PauseState.Level.WORLD setget set_paused_at_level
export (PauseState.Level) var pause_level := PauseState.Level.WORLD

func set_paused_at_level(val):
	paused_at_level = val
	if is_instance_valid(Pause) and is_inside_tree():
		_on_pause_changed(Pause.state)

func _ready() -> void:
	Pause.connect("changed",self,"_on_pause_changed")
	var parent = get_parent()
	if parent.has_signal("pause"):
		parent.connect("pause",self,"pause")
	if parent.has_signal("unpause"):
		parent.connect("unpause",self,"unpause")
	
	_on_pause_changed(Pause.state)

func _on_pause_changed(pause_state):
	if pause_state >= (1<<paused_at_level):
		get_parent().pause_mode = PAUSE_MODE_INHERIT
	else:
		get_parent().pause_mode = PAUSE_MODE_PROCESS

func pause():
	Pause.pause(pause_level)
func unpause():
	Pause.unpause(pause_level)
