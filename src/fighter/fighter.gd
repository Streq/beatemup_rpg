extends KinematicBody2D
class_name Fighter
signal dead

export var velocity := Vector2() 
export var gravity := Vector2()
export var team := 0

export var horizontal_decceleration = 0.0
export var horizontal_acceleration = 0.0
export var horizontal_air_acceleration = 0.0
export var horizontal_air_decceleration = 0.0
export var speed = 75.0
export var jump_speed = 100.0
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

func _ready() -> void:
	state_machine.initialize()
	health.connect("empty", self, "die")
	update_facing_dir()

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity += gravity*delta
	state_animation.advance(delta)
	state_machine.physics_update(delta)


func jump():
	velocity.y -= jump_speed
	pass

func die():
	if !state_machine.current.is_dead_state:
		state_machine.current.goto("dead_air")
		emit_signal("dead")
