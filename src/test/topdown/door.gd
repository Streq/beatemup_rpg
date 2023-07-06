extends Node2D

export (String, FILE, "*.tscn") var scene : String

var triggering := false

func _physics_process(delta: float) -> void:
	if triggering:
		return
	var grid = get_parent().get_parent()
	var tile = grid.world_to_map(grid.to_local(global_position))
	var entity = grid.get_entity_at_tile_ignore_trail(tile)
	if entity:
		trigger(entity)
	

func trigger(entity):
	triggering = true
	
	yield(entity, "step_finished")

	get_tree().change_scene(scene) 
	triggering = false
