extends Node

var player
export var PLAYER : PackedScene


func remove_from_map():
	if !is_instance_valid(player):
		player = Group.get_one("overworld_player")
	if player.is_inside_tree():
		player.get_parent().remove_child(player)

func add_to_map(door):
	refresh_player()
	var entities = Group.get_one("entities")
	var grid = entities.get_parent()
	
	entities.add_child(player)
	player.grid = grid
	player.global_position = door.global_position
	for entity in Group.get_all("overworld_player"):
		if entity != player:
			entity.queue_free()
	grid._clean_dead_entities()
	player.facing_dir = door.facing_dir
	if door.on_entry_walk_dir:
		player.step(door.on_entry_walk_dir)

func _populate(player:Node):
	player.add_child(preload("res://src/topdown/player/camera.tscn").instance())
	player.add_child(preload("res://src/topdown/player/controller.tscn").instance())
	player.add_to_group("overworld_player")

func get_player():
	refresh_player()
	return player

func refresh_player():
	if !is_instance_valid(player):
		player = PLAYER.instance()
		_populate(player)
