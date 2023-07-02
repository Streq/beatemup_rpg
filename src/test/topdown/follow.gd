extends Node

export var follow_path : NodePath
onready var follow = get_node(follow_path) 


func get_dir():
	var dir = get_parent().direction_to(follow)
	var grid = get_parent().grid
	var target_tile = grid.get_current_tile(get_parent()) + dir
	if grid.get_entity_at_tile_ignore_trail(target_tile):
		return Vector2()
	return dir
	
func get_interact():
	return false
