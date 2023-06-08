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
var dist = Vector2()
const RETREAT_FRAMES = 120

func _ready() -> void:
	yield(get_parent(),"ready")
	dir = get_parent().facing_dir
	var state_machine : StateMachine = get_parent().state_machine
	state_machine.connect("state_changed", self, "on_character_state_changed")

func _physics_process(delta: float) -> void:
	var input = get_parent().input_state
	dist = get_dist_to_player()
	match state:
		ADVANCE:
			input.dir.x = sign(dist.x)
			input.B.pressed = false
			input.A.pressed = false
			
			if abs(dist.x)<64.0:
				change_state(ATTACK)
		ATTACK:
			input.dir.x = dist.x
			input.B.pressed = get_character_state() in ["idle","walk","run","air"]
			input.A.pressed = false

		RETREAT:
			input.dir.x = dirx
			input.B.pressed = false
			input.A.pressed = true
			
			retreat_frames+=1
			if retreat_frames >= RETREAT_FRAMES:
				change_state(ADVANCE)

func change_state(new_state):
	state = new_state
	match state:
		RETREAT:
			retreat_frames = 0
			dirx = -sign(dist.x)

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
	
