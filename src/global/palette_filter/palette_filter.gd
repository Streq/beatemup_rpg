extends Node
tool

export var current : int = 0 setget set_palette
export var current_name : String setget set_palette_by_name
var darkness_offset : int = 0
onready var palettes = $palettes
onready var light: ColorRect = $"%light"
onready var palette_filter: ColorRect = $"%palette_filter"

func _input(event: InputEvent) -> void:
	if Engine.editor_hint:
		return
	if event.is_action_pressed("R",true):
		set_palette(current+1)
	if event.is_action_pressed("L",true):
		set_palette(current-1)
	if event.is_action_pressed("X",true):
		set_darkness_offset(darkness_offset-1)
	if event.is_action_pressed("Y",true):
		set_darkness_offset(darkness_offset+1)

func set_palette_by_name(val):
	if !palettes or !palettes.map.has(val):
		return
	current_name = val
	print(val," corresponds to an existing palette")
	set_palette(palettes.map[current_name])
	
	

func set_palette(index):
	if !palettes:
		return
	current = posmod(index,palettes.get_children().size())
	update_palette()

func set_darkness_offset(val:int):
	darkness_offset = clamp(val,-3,3)
	light.material.set_shader_param("offset",darkness_offset)
	
func update_palette():
	var palette_arr = palettes.get_children()
	palette_filter.palette = palette_arr[current].colors
	current_name = palette_arr[current].name
	property_list_changed_notify()
