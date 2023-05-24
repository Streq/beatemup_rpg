extends Node


func fade_to_darkness_level(level:int,time:float):
	var tween = create_tween()
	tween.tween_method(PaletteFilter,"set_darkness_offset",PaletteFilter.darkness_offset,level,time)
	tween.tween_interval(0.25)
	return tween
	
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("C"):
#		fade_to_darkness_level(-3,1.0)
