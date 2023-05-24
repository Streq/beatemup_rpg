extends CharacterState
onready var door_detect: Area2D = $"%door_detect"

func _enter(params) -> void:
	var door : Door = door_detect.get_overlapping_areas()[0].owner
	door.trigger()
	#hacer al jugador invulnerable
	#animar al jugador caminando para atras


func _physics_update(delta: float):
	root.velocity = Vector2()
