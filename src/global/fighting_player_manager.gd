extends Node

var player
export var PLAYER : PackedScene
export var ADDONS : PackedScene

func remove_from_map():
	if !is_instance_valid(player):
		player = Group.get_one("player")
	if player.is_inside_tree():
		player.get_parent().remove_child(player)

func add_to_map(door):
	refresh_player()
	get_tree().call_group("player", "queue_free")
	
	door.get_parent().add_child(player)
	player.position = door.position
	player.show()
	player.state_machine.current.goto("come_through_door")
	yield(get_tree(),"idle_frame")
	RoomGlobal.emit_signal("player_entered", player)
	
	

func _populate(player:Node):
	var addons = ADDONS.instance()
	for child in addons.get_children():
		addons.remove_child(child)
		player.add_child(child)
	player.team = -1
	player.add_to_group("player")

func get_player():
	refresh_player()
	return player

func refresh_player():
	if !is_instance_valid(player):
		player = PLAYER.instance()
		_populate(player)
