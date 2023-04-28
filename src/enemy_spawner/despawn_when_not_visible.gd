extends VisibilityNotifier2D

func _ready() -> void:
	set_process(false)
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	set_process(true)

func _process(delta: float) -> void:
	if !is_on_screen():
		despawn()

func despawn():
	get_parent().queue_free()
