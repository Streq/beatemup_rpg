extends Node2D
signal step_finished

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var sprite: Sprite = $"%Sprite"
onready var pivot: Node2D = $"%pivot"
onready var grid = get_parent()

#if true, when the character steps, the tile they're stepping from
#remains occupied until the end of the step
#effectively occupying both the tile-from and tile-to during the step
#if false, only the tile-to is occupied, and the tile-from is instantly freed
export var trailing_step := true
export var step_speed := 0.2
var anims = {
	Vector2.DOWN: {IDLE: "idle_front", STEP: "step_front", FAILED_STEP: "step_front"},
	Vector2.UP: {IDLE: "idle_back", STEP: "step_back", FAILED_STEP: "step_back"},
	Vector2.LEFT: {IDLE: "idle_side", STEP: "step_side", FAILED_STEP: "step_side"},
	Vector2.RIGHT: {IDLE: "idle_side", STEP: "step_side", FAILED_STEP: "step_side"}
}

onready var controller: Node = $controller


func _physics_process(delta: float) -> void:
	aim_dir = make_single_dir(controller.get_dir())
	if !aim_dir:
		return
	move()


enum { IDLE, STEP, FAILED_STEP}
var state = IDLE
var facing_dir = Vector2.DOWN
var aim_dir = Vector2.ZERO


func move():
	if !aim_dir:
		return
	match state:
		STEP:
			pass
		IDLE, FAILED_STEP:
			facing_dir = aim_dir
			if grid.attempt_move(self, facing_dir):
				var final_position = self.position
				self.position = self.position - facing_dir*16.0
				var tween = create_tween()
				tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
				tween.tween_property(self, "position", final_position, step_speed)
				if !trailing_step:
					emit_signal("step_finished")
#				else:
#					var tween2 = create_tween()
#					tween2.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
#					tween2.tween_interval(0.2)
#					tween2.tween_callback(self,"emit_signal",["step_finished"])
				goto(STEP)
			elif state == IDLE:
				goto(FAILED_STEP)
	pass


var right_leg_step := false


func goto(new_state):
	state = new_state
	
	match state:
		STEP, FAILED_STEP:
			sprite.flip_h = false
			if facing_dir.x < 0:
				sprite.flip_h = true
			if facing_dir.y:
				sprite.flip_h = right_leg_step
		IDLE:
			sprite.flip_h = false
			if facing_dir.x < 0:
				sprite.flip_h = true
			if facing_dir.y:
				sprite.flip_h = right_leg_step
	animation_player.play("RESET")
	animation_player.advance(0)
	var animation_name = anims[facing_dir][state]
	var animation : Animation = animation_player.get_animation(animation_name)
	var playback_speed = animation.length/step_speed
	animation_player.playback_speed = playback_speed
	animation_player.play(animation_name)
	animation_player.advance(0)

func _on_animation_finished(animation):
	match state:
		STEP, FAILED_STEP:
			emit_signal("step_finished")
			right_leg_step = !right_leg_step
			goto(IDLE)
			move()
		


func _ready():
	animation_player.connect(
		"animation_finished", self, "_on_animation_finished"
	)
	goto(IDLE)


static func make_single_dir(dir):
	return Vector2(sign(dir.x) if !dir.y else 0.0, sign(dir.y))
