extends Node


func fade_to_darkness_level(level:int,time:float):
	var tween = create_tween()
	tween.tween_method(PaletteFilter.filter,"set_darkness_offset",PaletteFilter.filter.darkness_offset,level,time)
	tween.tween_interval(0.1)
	return tween
	
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("C"):
#		fade_to_darkness_level(-3,1.0)
