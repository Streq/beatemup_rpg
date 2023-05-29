extends Node

func _ready() -> void:
	var fighter : Fighter = get_parent()
	yield(fighter,"ready")
	fighter.connect("target_hit",self,"on_target_hit")
	RoomGlobal.connect("room_changed",HudLayer.enemy_health,"untrack")
func on_target_hit(target):
	HudLayer.enemy_health.track(target)
