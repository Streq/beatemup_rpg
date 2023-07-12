extends Node

signal room_changed()
signal player_entered(player)
onready var tree = get_tree()

onready var overworld_player_manager = $overworld_player_manager
onready var fighting_player_manager = $fighting_player_manager

var fighter_player : Fighter
func remove_fighter_player():
	if fighter_player:
		fighter_player.get_parent().remove_child(fighter_player)

func goto_room2(path: String, door_id):
	if !fighter_player:
		fighter_player = Group.get_one("player")
	fighter_player.hide()
	yield(Fade.fade_to_darkness_level(-3, 0.3), "finished")
	remove_fighter_player()
	tree.change_scene(path)
	emit_signal("room_changed")
	yield(tree, "idle_frame")
	if fighter_player:
		tree.call_group("player", "queue_free")
		for door in Group.get_all("door"):
			if door.id == door_id:
				door.get_parent().add_child(fighter_player)
				fighter_player.position = door.position
		fighter_player.show()
		fighter_player.state_machine.current.goto("come_through_door")
		yield(get_tree(),"idle_frame")
		emit_signal("player_entered",fighter_player)
	yield(Fade.fade_to_darkness_level(0,0.3),"finished")

func goto_map2(path: String, door_id: String):
	remove_overworld_player()
	remove_fighter_player()
	tree.change_scene(path)
	yield(tree,"idle_frame")
	add_overworld_player(door_id)

var overworld_player : Node2D
func remove_overworld_player():
	if !overworld_player:
		overworld_player = Group.get_one("overworld_player")
	if overworld_player.is_inside_tree():
		overworld_player.get_parent().remove_child(overworld_player)

func add_overworld_player(door_id):
	var entities = Group.get_one("entities")
	if !entities:
		return
	var grid = entities.get_parent()
	var door = get_door_by_id(door_id)
	entities.add_child(overworld_player)
	overworld_player.grid = grid
	overworld_player.global_position = door.global_position
	for player in Group.get_all("overworld_player"):
		if player != overworld_player:
			player.queue_free()
	yield(Fade,"fade_in_completed")
	grid._clean_dead_entities()
	overworld_player.facing_dir = door.facing_dir
	if door.on_entry_walk_dir:
		overworld_player.step(door.on_entry_walk_dir)


func get_door_by_id(door_id):
	for door in Group.get_all("door"):
		if door.id == door_id:
			return door
	return null




func goto_map(path: String, door_id: String):
	goto_room(path, door_id)

func goto_room(scene_path: String, door_id: String):
	if is_overworld_map():
		exit_overworld_map()
	else:
		exit_fighting_map()

	tree.change_scene(scene_path)
	yield(tree,"idle_frame")

	var door = get_door_by_id(door_id)

	if is_overworld_map():
		enter_overworld_map(door)
	else:
		enter_fighting_map(door)

func is_overworld_map():
	return tree.has_group("grid")
	
func exit_overworld_map():
	overworld_player_manager.remove_from_map()
func exit_fighting_map():
	fighting_player_manager.remove_from_map()
	
func enter_overworld_map(door):
	overworld_player_manager.add_to_map(door)
func enter_fighting_map(door):
	fighting_player_manager.add_to_map(door)

