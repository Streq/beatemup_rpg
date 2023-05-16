extends KinematicBody2D
class_name Fighter
signal dead
signal hurt
signal frame(delta)
signal hitstun(frames)

export var velocity := Vector2() 
export var gravity := 200.0
export var team := 0

export var horizontal_decceleration = 0.0
export var horizontal_acceleration = 0.0
export var horizontal_air_acceleration = 0.0
export var horizontal_air_decceleration = 0.0
export var speed = 75.0
export var run_speed = 125.0
export var jump_speed = 100.0
export var fast_fall_speed = 100.0
export var fall_speed = 75.0

export var air_jumps := 0
export var available_air_jumps := 0

export var hitbox_touch_level := 0

export (float, -1.0, 1.0, 2.0) var facing_dir := 1.0 setget set_facing_dir
func set_facing_dir(val):
	val = sign(val)
	if val == 0.0 or facing_dir == val:
		return
	facing_dir = val
	if !is_inside_tree():
		return
	update_facing_dir()

func update_facing_dir():
	pivot.scale.x = abs(pivot.scale.x)*facing_dir

onready var state_animation: AnimationPlayer = $"%state_animation"
onready var status_animation: AnimationPlayer = $"%status_animation"
onready var input_state: InputState = $"%input_state"
onready var health: Bar = $"%health"
onready var display: Node2D = $"%display"
onready var pivot: Node2D = $"%pivot"
onready var state_machine: StateMachine = $"%state_machine"
onready var hitstun = $"%hitstun"

func _ready() -> void:
	state_machine.initialize()
	health.connect("empty", self, "die")
	update_facing_dir()

func refill_air_jumps():
	available_air_jumps = air_jumps

func _physics_process(delta: float) -> void:
	if is_on_floor():
		refill_air_jumps()
	
	if shake_frames:
		shake_frames -= 1
		shake_frame()
	else:
		display.position = Vector2()
	if freeze_frames:
		freeze_frames -= 1
		return
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if velocity.y < fall_speed:
		velocity.y += gravity*delta
		
	state_animation.advance(delta)
	state_machine.physics_update(delta)
	emit_signal("frame",delta)


func die():
	if !state_machine.current.is_dead_state:
		state_machine.current.goto("dead_air")
		emit_signal("dead")

#func get_hurt():
#	emit_signal("hurt")

var freeze_frames := 0
func freeze(frames):
	freeze_frames = frames

var shake_frames := 0
func shake(frames):
	shake_frames = frames

const shake_interval := 1
var shake_sign = 1
func shake_frame():
	if shake_frames%shake_interval == 0:
		shake_sign = -shake_sign
	#either 1 or -1 at random
	var x = (randi()%2)*2-1
	#flips between frames
	var y = shake_sign
	display.position = Vector2(x,y)*shake_frames/4


func hitstun(frames):
	emit_signal("hitstun",frames)

