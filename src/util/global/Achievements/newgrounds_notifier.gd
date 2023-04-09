extends Node
tool
onready var list: Node = $"%list"

export var id_map = {}

func _ready() -> void:
	for child in list.get_children():
		if !id_map.has(child.name):
			id_map[child.name] = 0


func completed(achievement_name):
	if !id_map.has(achievement_name):
		return
	var achievement_id = id_map[achievement_name]
	NGIO.request("Medal.unlock", {"id": achievement_id})
