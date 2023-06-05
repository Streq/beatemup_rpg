extends KinematicBody2D


var velocity := Vector2()
var gravity := Vector2(0,100)
func _physics_process(delta: float) -> void:
	velocity += gravity*delta
	if is_floor:
		velocity = move_and_slide_with_snap(velocity,Vector2(0,8), Vector2.UP)
	else:
		velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		is_floor = true
		var floor_tangent = -get_floor_normal().tangent()
		var dirx = Input.get_axis("ui_left","ui_right")
		velocity = floor_tangent * dirx * 100.0
#		velocity.x = dirx * 100.0
	if Input.is_action_just_pressed("A"):
		velocity.y = -100.0
		is_floor = false
	
var is_floor = false
