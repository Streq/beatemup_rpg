extends CharacterState
onready var door_detect: Area2D = $"%door_detect"

var door : Door
func _enter(params) -> void:
	door = door_detect.get_overlapping_areas()[0].owner
func _on_animation_finished(anim):
	._on_animation_finished(anim)
	door.exit_through()

func _physics_update(delta: float):
	root.velocity = Vector2()
