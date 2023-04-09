extends Node2D


export var init_size := 1500
var size = 0

#OBJECT instances must have "spawn" and "despawn" functions 
#and a "despawn" signal
export var OBJECT : PackedScene

var objects = []
var unused_objects = []
func _ready() -> void:
	for i in init_size:
		var instance = new_instance()
		instance.call_deferred("despawn")
		

func get_one():
	if unused_objects.empty():
		var instance = new_instance()
		instance.call_deferred("spawn")
		return instance
	
	var instance  = unused_objects.pop_back()
	instance.spawn()
	return instance
	

func new_instance():
	var instance = OBJECT.instance()
#	instance.index = size
	size += 1
	objects.push_back(instance)
	instance.connect("despawn",self,"_on_instance_despawn",[instance])
	
	call_deferred("add_child",instance)
	return instance
	

func _on_instance_despawn(instance):
	unused_objects.append(instance)
	pass
