extends Node

signal room_changed()
signal player_entered(player)
onready var tree = get_tree()

func goto_room(path: String, door_id: int):
	var player : Fighter = Group.get_one("player")
	player.hide()
	yield(Fade.fade_to_darkness_level(-3,0.3),"finished")
	if player:
		player.get_parent().remove_child(player)
	tree.change_scene(path)
	emit_signal("room_changed")
	yield(tree, "idle_frame")
	if player:
		tree.call_group("player", "queue_free")
		for door in Group.get_all("door"):
			if door.id == door_id:
				door.get_parent().add_child(player)
				player.position = door.position
		player.show()
		player.state_machine.current.goto("come_through_door")
		yield(get_tree(),"idle_frame")
		emit_signal("player_entered",player)
	yield(Fade.fade_to_darkness_level(0,0.3),"finished")
func goto_map(path: String, door_id: String):
#	remove_overworld_player()
#	remove_fighter_player()
	tree.change_scene(path)
	add_overworld_player(door_id)

var overworld_player
func add_overworld_player(door_id):
	Group.get_one("entities").add_child(overworld_player)
	var door = get_door_by_id(door_id)
	overworld_player.global_position = door.global_position
	overworld_player.facing_dir = door.facing_dir
	if door.step_dir:
		overworld_player.step(door.step_dir)


func get_door_by_id(door_id):
	for door in Group.get_all("door"):
		if door.id == door_id:
			return door
	return null
	
