extends KinematicBody2D

var velocity := Vector2()
var gravity := Vector2(0, 100)

var is_floor = false
var move_strategy = null
onready var move_strategies: Dictionary = $move_strategies.map
var grounded := false

func _physics_process(delta: float) -> void:
	velocity += gravity * delta
	if is_floor:
		move_strategy = move_strategies["move_and_slide_snap_no_fall_strategy"]
	else:
		move_strategy = move_strategies["move_and_slide_strategy"]
	move_strategy.move(self)
	var dirx = Input.get_axis("ui_left", "ui_right")
	if grounded:
		is_floor = true
		var floor_tangent = -get_floor_normal().tangent()
		print(floor_tangent)
		velocity = floor_tangent * dirx * 100.0
	else:
		velocity.x = dirx * 100.0
#		velocity.x = dirx * 100.0
	if Input.is_action_just_pressed("A"):
		velocity.y = -100.0
		is_floor = false
