extends Node

func _ready() -> void:
	get_parent().connect("dead",self,"_on_dead")

func _on_dead():
	get_tree().reload_current_scene()
