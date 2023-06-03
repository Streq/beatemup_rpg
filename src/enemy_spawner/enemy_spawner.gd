extends Node2D

signal spawned(instance)

export var SPAWN : PackedScene
enum TriggerCondition {
	ENTERED,
	EXITED
}
export (TriggerCondition) var trigger_on_screen:int

onready var visibility_notifier: VisibilityNotifier2D = $VisibilityNotifier2D
var instance = null

func _ready() -> void:
	match trigger_on_screen:
		TriggerCondition.ENTERED:
			visibility_notifier.connect("screen_entered",self,"_on_screen_entered")
		TriggerCondition.EXITED:
			visibility_notifier.connect("screen_exited",self,"_on_screen_entered")
		
	

func _on_screen_entered():
	if is_instance_valid(instance):
		return
	instance = SPAWN.instance()
	var player = Group.get_one("player")
	if is_instance_valid(player):
		instance.facing_dir = sign(player.global_position.x - global_position.x)
	emit_signal("spawned",instance)
	add_child(instance)
	pass
