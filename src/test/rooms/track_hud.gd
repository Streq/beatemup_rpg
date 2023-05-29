extends Node

func _ready() -> void:
	yield(get_parent(),"ready")
	HudLayer.player_health.track(get_parent())
