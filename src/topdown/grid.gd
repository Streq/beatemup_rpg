extends TileMap

var tile_to_entity_map := {} 
var entity_to_tile_map := {}

func get_entity_at_tile(tile: Vector2):
	return tile_to_entity_map.get(tile)

func get_entity_at_tile_ignore_trail(tile: Vector2):
	var entity = get_entity_at_tile(tile)
	if !entity:
		return null
	var latest_tile = entity_to_tile_map[entity]
	if latest_tile == tile:
		return entity
	else:
		return null
func get_current_tile(entity):
	return entity_to_tile_map.get(entity)

func _occuppy(entity, map_pos):
	tile_to_entity_map[map_pos] = entity
	entity_to_tile_map[entity] = map_pos
	set_cellv(map_pos, tile_set.find_tile_by_name("character"))
#	print(tile_to_entity_map)

func attempt_move(entity: Node2D, direction: Vector2) -> bool:
	var step = Vector2(
		sign(direction.x), sign(direction.y) if !direction.x else 0.0
	)
	if !step:
		return true
	return _attempt_orthogonal_move_unit_step(entity, step)


func _attempt_orthogonal_move_unit_step(entity: Node2D, step: Vector2):
	var old_position = world_to_map(entity.position)
	var new_position = old_position + step
	var cell = get_cellv(new_position)
	if cell != -1:
		return false
	entity.global_position = map_to_world(new_position) + Vector2(8, 8)
	_occuppy(entity, new_position)
	yield(entity, "step_finished")
	_free_space(old_position)
	return true

func _free_space(old_position):
	tile_to_entity_map.erase(old_position)
	set_cellv(old_position, -1)
#	print(tile_to_entity_map)

func _ready() -> void:
	for child in get_children():
		_occuppy(child, world_to_map(child.position))
