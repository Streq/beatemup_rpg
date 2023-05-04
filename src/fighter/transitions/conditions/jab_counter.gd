extends Node

export var trigger_on_count := 2
export var time_before_reset := 0.5

onready var timeout: Timer = $timeout


var count = 0

func check():
	return count >= trigger_on_count

func increment_count():
	count+=1
	timeout.stop()
func resume_timer():
	timeout.start()
func _ready() -> void:
	timeout.wait_time = time_before_reset
	timeout.connect("timeout",self,"reset_count")

func reset_count():
	count = 0
