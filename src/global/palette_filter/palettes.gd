extends Control

var current : int = 0

onready var palettes = get_children()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("R",true):
		palettes[current].hide()
		current = (current+1)%palettes.size()
		palettes[current].show()
	if event.is_action_pressed("L",true):
		palettes[current].hide()
		current = posmod((current-1),palettes.size())
		palettes[current].show()
	
