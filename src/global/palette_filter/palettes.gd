extends Node
tool

const PALETTE = preload("palette.tscn")

var map := {}

func _ready() -> void:
	for child in get_children():
		
		map[child.name] = child.get_position_in_parent()

#func _ready() -> void:
#	var palettes = owner.get_node("%palette_layer").get_children()
#	print(palettes)
#	for palette in palettes:
#		for child in get_children():
#			if child.name == palette.name:
#				continue
#		var p = PALETTE.instance()
#		p.colors = palette.palette
#		p.name = palette.name
#		add_child(p)
#		p.set_owner(get_tree().get_edited_scene_root())



