extends Node
signal fade_out_completed()
signal fade_in_completed()


func fade_and_come_back(darkness_level:int, time_out:float, time_hold:float,  time_in:float):
	Pause.pause()
	yield(fade_to_darkness_level(darkness_level, time_out), "finished")
	emit_signal("fade_out_completed")
	
	if time_hold:
		yield(get_tree().create_timer(time_hold), "timeout")
	
	yield(fade_to_darkness_level(0, time_in), "finished")
	emit_signal("fade_in_completed")
	Pause.unpause()

func fade_to_darkness_level(level:int,time:float) -> SceneTreeTween:
	var tween := create_tween()
	tween.tween_method(PaletteFilter.filter,"set_darkness_offset",PaletteFilter.filter.darkness_offset,level,time)
	tween.tween_interval(0.1)
	tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	return tween
	
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("C"):
#		fade_to_darkness_level(-3,1.0)
