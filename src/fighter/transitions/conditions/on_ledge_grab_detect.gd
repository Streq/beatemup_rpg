extends Node

onready var ledge_detect: Node2D = $"%ledge_detect"

var point = null
var check = false

export var y_velocity_has_to_be_higher_than := -10.0

func check():
	return ledge_detect.has_ledge and owner.velocity.y>y_velocity_has_to_be_higher_than
