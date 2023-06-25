extends Node2D
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var sprite: Sprite = $Sprite

signal step_finished

onready var grid = get_parent()

var anims = {
	Vector2.DOWN: {IDLE: "idle_front", STEP: "step_front"},
	Vector2.UP: {IDLE: "idle_back", STEP: "step_back"},
	Vector2.LEFT: {IDLE: "idle_side", STEP: "step_side"},
	Vector2.RIGHT: {IDLE: "idle_side", STEP: "step_side"}
}

onready var controller: Node = $controller


func _physics_process(delta: float) -> void:
	aim_dir = make_single_dir(controller.get_dir())
	if !aim_dir:
		return
	move()


enum { IDLE, STEP }
var state = IDLE
var facing_dir = Vector2.DOWN
var aim_dir = Vector2.ZERO


func move():
	if !aim_dir:
		return
	match state:
		STEP:
			pass
		IDLE:
			goto(STEP)
	pass


var right_leg_step := false


func goto(new_state):
	state = new_state
	if aim_dir:
		facing_dir = aim_dir
	
	animation_player.play(anims[facing_dir][state])
	
	match state:
		STEP:
			sprite.flip_h = false
			if facing_dir.x < 0:
				sprite.flip_h = true
			if facing_dir.y:
				right_leg_step = !right_leg_step
				sprite.flip_h = right_leg_step
			if grid.attempt_move(self, facing_dir):
				sprite.position = -facing_dir * 16.0
				var tween = create_tween()
				tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
				tween.tween_property(sprite, "position", Vector2.ZERO, 0.2)
				var tween2 = create_tween()
#				tween2.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
#				tween2.tween_interval(0.1)
#				tween2.tween_callback(self,"emit_signal",["step_finished"])
				
		IDLE:
			emit_signal("step_finished")
			sprite.flip_h = false
			if facing_dir.x < 0:
				sprite.flip_h = true
			if facing_dir.y:
				sprite.flip_h = right_leg_step


func _on_animation_finished(animation):
	match state:
		STEP:
			var dir = controller.get_dir()
			if dir:
				goto(STEP)
			else:
				goto(IDLE)


func _ready():
	animation_player.connect(
		"animation_finished", self, "_on_animation_finished"
	)
	goto(IDLE)


static func make_single_dir(dir):
	return Vector2(sign(dir.x) if !dir.y else 0.0, sign(dir.y))
