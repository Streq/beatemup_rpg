extends Node2D

onready var sight: Area2D = $sight
onready var attack_cooldown: Timer = $attack_cooldown

export var turn_to_face_enemy := false

func _ready() -> void:
	process_priority = -100000000

func _physics_process(delta: float) -> void:
	var input = get_parent().input_state
	var player = Group.get_one("player")
	if player and sight.overlaps_body(player):
		var dir_to_target = global_position.direction_to(player.global_position).x
		var facing_enemy = sign(get_parent().facing_dir) == sign(dir_to_target)
		if turn_to_face_enemy and !facing_enemy:
			input.dir.x = dir_to_target
		elif facing_enemy and attack_cooldown.is_stopped():
			input.B.pressed = !input.B.pressed
			attack_cooldown.start()
		return
	input.B.pressed = false
	
