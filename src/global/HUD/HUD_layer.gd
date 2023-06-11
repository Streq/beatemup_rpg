extends CanvasLayer

var already_tracking := false
onready var player_health: HBoxContainer = $"%player_health"
onready var enemy_health: HBoxContainer = $"%enemy_health"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
