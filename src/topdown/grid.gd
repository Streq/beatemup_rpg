extends TileMap

func _occuppy(map_pos):
	set_cellv(map_pos, tile_set.find_tile_by_name("character"))

func attempt_move(entity: Node2D, direction: Vector2) -> bool:
	var step = Vector2(
		sign(direction.x), sign(direction.y) if !direction.x else 0.0
	)
	if !step:
		return false
	return _attempt_move_one_step(entity, step)


# Assumes unit orthogonal movement
func _attempt_move_one_step(entity: Node2D, step: Vector2):
	var old_position = world_to_map(entity.position)
	var new_position = old_position + step
	var cell = get_cellv(new_position)
	if cell != -1:
		return false
	entity.global_position = map_to_world(new_position) + Vector2(8, 8)
	set_cellv(new_position, tile_set.find_tile_by_name("character"))
	entity.connect(
		"step_finished", self, "_free_space", [old_position], CONNECT_ONESHOT
	)
	return true

func _free_space(old_position):
	set_cellv(old_position, -1)

func _ready() -> void:
	for child in get_children():
		_occuppy(world_to_map(child.position))
