extends Node2D

export (String, FILE, "*.tscn") var scene : String
export var to_indoors := false

export var id := ""
export var on_entry_walk_dir := Vector2()

func _ready() -> void:
	add_to_group("door")

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
	entity.controller.disable()
	yield(entity, "step_finished")

	var darkness_level = 3 if to_indoors else -3
	Fade.fade_and_come_back(darkness_level, 0.3, 0.1, 0.3)
	yield(Fade, "fade_out_completed")
	entity.controller.enable()
	
	get_tree().change_scene(scene) 
	triggering = false
