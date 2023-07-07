extends Node2D
signal interacted_with(by)
signal step_finished
signal on_tile

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

export var turn_lag := true

var anims = {
	Vector2.DOWN:
	{
		IDLE: "idle_front",
		STEP: "step_front",
		FAILED_STEP: "step_front",
		TURN: "step_front"
	},
	Vector2.UP:
	{
		IDLE: "idle_back",
		STEP: "step_back",
		FAILED_STEP: "step_back",
		TURN: "step_back"
	},
	Vector2.LEFT:
	{
		IDLE: "idle_side",
		STEP: "step_side",
		FAILED_STEP: "step_side",
		TURN: "step_side"
	},
	Vector2.RIGHT:
	{
		IDLE: "idle_side",
		STEP: "step_side",
		FAILED_STEP: "step_side",
		TURN: "step_side"
	}
}

onready var controller: Node = $controller

 
func _physics_process(delta: float) -> void:
	if interacting:
		return
	aim_dir = make_single_dir(controller.get_dir())
	interact = interact or controller.get_interact()
	
	if interact:
		attempt_interact()
	elif aim_dir:
		move()
	match state:
		IDLE, FAILED_STEP:
			emit_signal("on_tile")

func attempt_interact():
	match state:
		IDLE, FAILED_STEP:
			var current_tile = grid.get_current_tile(self)
			var target_tile = current_tile + facing_dir
			var entity = grid.get_entity_at_tile_ignore_trail(target_tile)
			if entity:
				goto(IDLE)
				interacting = true
				yield(entity, "on_tile")
				entity.interacted_with(self)
				interacting = false
				
			interact = false

func interacted_with(by):
	aim_dir = Vector2()
	emit_signal("interacted_with", by)

enum { IDLE, STEP, FAILED_STEP, TURN }
var state = IDLE
export var facing_dir = Vector2.DOWN
var aim_dir = Vector2.ZERO

var interact = false
var interacting = false

func face_toward(character):
	facing_dir = direction_to(character)
	goto(IDLE)
	
	
func direction_to(character):
	var from = grid.get_current_tile(self)
	var to = grid.world_to_map(character.position)
	var dir = make_single_dir(to - from)
	
#	print(dir)
	return dir
func move():
	if !aim_dir:
		return
	match state:
		STEP:
			pass
		TURN:
			pass
		IDLE:
			if !turn_lag or facing_dir == aim_dir:
				step(aim_dir)
			else:
				turn()
		FAILED_STEP:
			step(aim_dir)
	pass


func turn():
	facing_dir = aim_dir
	goto(TURN)


func step(dir):
	facing_dir = dir
	if grid.attempt_move(self, dir):
		var final_position = self.position
		self.position = self.position - facing_dir * 16.0
		var tween = create_tween()
		tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(self, "position", final_position, step_speed)
		if !trailing_step:
			emit_signal("step_finished")
		goto(STEP)
	elif state == IDLE:
		goto(FAILED_STEP)

var right_leg_step := false


func goto(new_state):
	state = new_state

	update_facing_dir()
	
	animation_player.play("RESET")
	animation_player.advance(0)
	var animation_name = anims[facing_dir][state]
	var animation: Animation = animation_player.get_animation(animation_name)
	var playback_speed = animation.length / step_speed
	animation_player.playback_speed = playback_speed
	animation_player.play(animation_name)
	animation_player.advance(0)

func update_facing_dir():
	sprite.flip_h = false
	if facing_dir.x < 0:
		sprite.flip_h = true
	if facing_dir.y:
		sprite.flip_h = right_leg_step

func _on_animation_finished(animation):
	match state:
		IDLE:
			pass
		STEP, FAILED_STEP, TURN:
			emit_signal("step_finished")
			right_leg_step = !right_leg_step
			goto(IDLE)
			emit_signal("on_tile")
			if interact:
				attempt_interact()
				return
			if aim_dir:
				facing_dir = aim_dir
				move()


func _ready():
	animation_player.connect(
		"animation_finished", self, "_on_animation_finished"
	)
	goto(IDLE)


static func make_single_dir(dir):
	return Vector2(sign(dir.x) if abs(dir.y)<abs(dir.x) else 0.0, sign(dir.y))
