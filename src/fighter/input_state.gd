extends Node
class_name InputState

var A : ButtonState = ButtonState.new()
var B : ButtonState = ButtonState.new()

#exists for debug purposes
var C : ButtonState = ButtonState.new()
var dir := Vector2() setget set_dir
var _prev_dir := Vector2()

func set_dir(val:Vector2):
	dir = val.limit_length()


func _physics_process(delta: float) -> void:
	stale()
	
func stale():
	A.stale()
	B.stale()
	C.stale()
	_prev_dir = dir

func copy_from(input_state: InputState):
	A.copy_from(input_state.A)
	B.copy_from(input_state.B)
	C.copy_from(input_state.C)
	_prev_dir = input_state._prev_dir
	dir = input_state.dir

func clear():
	A.clear()
	B.clear()
	C.clear()
	dir = Vector2()
	_prev_dir = Vector2()
func _to_string() -> String:
	return ("InputState (\n\tdir:%s,\n\tA:%s,\n\tB:%s\n)"%[dir,A,B])

func get_direction() -> Vector2:
	return dir


func is_just_pressed(button):
	return get(button).is_just_pressed()

func is_just_released(button):
	return get(button).is_just_released()

func is_pressed(button):
	return get(button).is_pressed()

func is_y_just_pressed(sign_y):
	return sign(_prev_dir.y) != sign(dir.y) and sign(dir.y) == (sign_y)

func is_x_just_pressed(sign_x):
	return sign(_prev_dir.x) != sign(dir.x) and sign(dir.x) == (sign_x)
