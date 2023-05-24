extends CanvasLayer


var current : int = 0
var darkness_offset : int = 0
onready var palettes = $palettes.get_children()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("R",true):
		set_palette(current+1)
	if event.is_action_pressed("L",true):
		set_palette(current-1)
	if event.is_action_pressed("X",true):
		set_darkness_offset(darkness_offset-1)
	if event.is_action_pressed("Y",true):
		set_darkness_offset(darkness_offset+1)
		
func set_palette(index):
	palettes[current].hide()
	current = posmod(index,palettes.size())
	update_palette()

func set_darkness_offset(val:int):
	darkness_offset = clamp(val,-3,3)
	update_palette()
	
func update_palette():
	var palette : ColorRect = palettes[current]
	palette.material.set_shader_param("offset",darkness_offset)
	palettes[current].show()
