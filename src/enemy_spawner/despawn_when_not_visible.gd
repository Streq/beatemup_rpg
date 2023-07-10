extends VisibilityNotifier2D

var frames = 0

func _process(delta: float) -> void:
	if frames < 5:
		frames += 1
		return
	if !is_on_screen():
		despawn()

func despawn():
	get_parent().queue_free()
