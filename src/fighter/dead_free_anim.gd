extends Node

func play():
	var tween = create_tween()
	tween.tween_property(owner,"visible",false, 0.1)
	tween.tween_property(owner,"visible",true, 0.1)
	tween.set_loops(5)
	yield(tween,"finished")
	owner.queue_free()
