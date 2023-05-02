extends Node

signal new_input
signal buffer_changed(val)

export (NodePath) onready var input_state = (get_node(input_state) if has_node(input_state) else null) as InputState 

export var idle_time_to_clear := 0.5

#time it takes for the combo buffer to end
onready var combo_timer: Timer = $combo_timer

#window of time for pressing several keys at the same time
export var simul_press_frames_threshold := 3
var simul_press_frames = simul_press_frames_threshold


#stores combos like A+B , 623B
var buffer = "" setget set_buffer

var simul_press = false
var is_latest = false

const buttons := ["A", "B"]



# how directions are gonna be represented in the buffer
# ↖ ↑ ↗   7 8 9
# ← · → = 4 5 6
# ↙ ↓ ↘   1 2 3
const dirs := {
		Vector2(-1.0,-1.0): "7", Vector2( 0.0,-1.0): "8", Vector2( 1.0, -1.0): "9",
		Vector2(-1.0, 0.0): "4", Vector2( 0.0, 0.0): "5", Vector2( 1.0,  0.0): "6",
		Vector2(-1.0, 1.0): "1", Vector2( 0.0, 1.0): "2", Vector2( 1.0,  1.0): "3"
	}
var held_direction := Vector2()

func _ready():
	combo_timer.wait_time = idle_time_to_clear


func check():
	var direction = input_state.get_direction().snapped(Vector2(1,1))
	#new direction?
	var input_changed = direction != held_direction
	var is_new_direction = input_changed and direction != Vector2.ZERO
	held_direction = direction
	if is_new_direction:
		_push_to_buffer(dirs[direction])
	for button in buttons:
		if input_state.is_just_pressed(button):
			if simul_press:
				buffer += "+"
			_push_to_buffer(button)
			input_changed = true
	if input_changed:
		emit_signal("new_input")
	
func _physics_process(delta):
	is_latest = false
	if combo_timer.is_stopped():
		self.buffer = ""
	if simul_press_frames <= 0:
		simul_press = false
	check()
	simul_press_frames -= 1
	
func _push_to_buffer(input):
	combo_timer.start()
	if simul_press_frames <= 0:
		simul_press_frames = simul_press_frames_threshold
		simul_press = true
	self.buffer += input
	is_latest = true
	
func set_input_state(val):
	input_state = val

func set_buffer(val):
	buffer = val
	emit_signal("buffer_changed", buffer)
