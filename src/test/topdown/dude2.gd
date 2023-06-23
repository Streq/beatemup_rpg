extends Node2D

signal step_finished()

onready var grid = get_parent()

var moving = false

func _physics_process(delta: float) -> void:
	if moving:
		return
	var dir = Input.get_vector("left2","right2","up2","down2")
	if grid.attempt_move(self, dir):
		moving = true
		yield(get_tree().create_timer(0.25),"timeout")
		emit_signal("step_finished")
		moving = false
