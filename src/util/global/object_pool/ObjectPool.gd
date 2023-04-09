extends Node2D

var map = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		map[child.name] = child


func get_one(pool_name : String):
	return map[pool_name].get_one()
