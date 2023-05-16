extends Node

onready var input_state : InputState = $input_state

#export var enabled := true setget set_enabled

func _physics_process(delta: float) -> void:
	input_state.A.pressed = Input.is_action_pressed("A")
	input_state.B.pressed = Input.is_action_pressed("B")
	input_state.C.pressed = Input.is_action_pressed("C")
	input_state.dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")


func disable():
	set_physics_process(false)

func enable():
	set_physics_process(true)
