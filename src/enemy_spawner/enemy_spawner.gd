extends Node2D


export var SPAWN : PackedScene
onready var visibility_notifier: VisibilityNotifier2D = $VisibilityNotifier2D
var instance = null

func _ready() -> void:
	visibility_notifier.connect("screen_entered",self,"_on_screen_entered")
	

func _on_screen_entered():
	if is_instance_valid(instance):
		return
	instance = SPAWN.instance()
	var player = Group.get_one("player")
	if is_instance_valid(player):
		instance.facing_dir = sign(player.global_position.x - global_position.x)
	add_child(instance)
	
	pass
