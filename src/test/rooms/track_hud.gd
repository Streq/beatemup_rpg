extends Node

func _ready() -> void:
	yield(get_parent(),"ready")
	HudLayer.player_health.track_soft(get_parent())
