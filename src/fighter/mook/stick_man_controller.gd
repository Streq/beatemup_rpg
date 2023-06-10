extends Node2D

enum {
	ADVANCE,
	RETREAT,
	ATTACK
}

var just_turned = false
var dir := 1.0

var state : int = ADVANCE 
var retreat_frames = 0
var dirx = 0.0
const RETREAT_FRAMES = 90


func _ready() -> void:
	yield(get_parent(),"ready")
	dir = get_parent().facing_dir
	var state_machine : StateMachine = get_parent().state_machine
	state_machine.connect("state_changed", self, "on_character_state_changed")

func _physics_process(delta: float) -> void:
	var fighter : Fighter = get_parent()
	var input = fighter.input_state
	var dist = get_dist_to_player()
	var facing_dir_to_player = sign(dist.x)
	match state:
		ADVANCE:
			input.dir.x = facing_dir_to_player
			input.B.pressed = false
			input.A.pressed = false
			
			if abs(dist.x)<60.0:
				change_state(ATTACK)
		ATTACK:
			input.dir.x = dist.x
			input.B.pressed = get_character_state() in ["idle","walk","run","air"]
			input.A.pressed = false

		RETREAT:
			input.B.pressed = false
			
			if fighter.facing_dir == dirx:
				input.dir.x = -dirx
				input.A.pressed = false
			else:
				input.dir.x = dirx
				input.A.pressed = true
			if get_character_state() in ["walk_back","idle","turn"]:
				if retreat_frames == 0:
					dirx = -facing_dir_to_player
				retreat_frames+=1
			if retreat_frames >= RETREAT_FRAMES:
				change_state(ADVANCE)

func change_state(new_state):
	state = new_state
	match state:
		RETREAT:
			retreat_frames = 0

func get_character_state()->String:
	return get_parent().state_machine.current.name

func on_character_state_changed(new_state):
	match new_state:
		"strike","reverse_strike":
			if randf()<0.25:
				change_state(ATTACK)
			else:
				change_state(RETREAT)

		"hurt":
			change_state(ATTACK)


func get_dist_to_player() -> Vector2:
	var player : Node2D = Group.get_one("player")
	if !is_instance_valid(player):
		return Vector2.ZERO
	return player.global_position - global_position

func get_facing_dir_to_player() -> float:
	return sign(get_dist_to_player().x)
	
