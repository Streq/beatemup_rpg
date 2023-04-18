extends Node
class_name InputState

var A : ButtonState = ButtonState.new()
var B : ButtonState = ButtonState.new()
var dir := Vector2() setget set_dir

func set_dir(val:Vector2):
	dir = val.limit_length()


func _physics_process(delta: float) -> void:
	stale()
	
func stale():
	A.stale()
	B.stale()

func copy_from(input_state: InputState):
	A.copy_from(input_state.A)
	B.copy_from(input_state.B)
	dir = input_state.dir

func clear():
	A.clear()
	B.clear()
	dir = Vector2()

func _to_string() -> String:
	return ("InputState (\n\tdir:%s,\n\tA:%s,\n\tB:%s\n)"%[dir,A,B])
func _ready() -> void:
	print(self)
