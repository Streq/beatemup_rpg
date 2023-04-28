extends Node

export var CONTROLLER : PackedScene

func _ready() -> void:
	get_parent().connect("spawned",self,"trigger")

func trigger(instance):
	instance.add_child(CONTROLLER.instance())
