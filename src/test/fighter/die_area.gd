extends Area2D


func _body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()
func _ready() -> void:
	connect("body_entered",self,"_body_entered")
