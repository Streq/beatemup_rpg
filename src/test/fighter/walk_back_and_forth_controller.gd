extends Node2D

export var time := 5.0
export var dir := 1.0

onready var timer = $Timer

func _physics_process(delta: float) -> void:
	var input = get_parent().input_state
	input.clear()
	input.dir.x = dir

func _ready() -> void:
	timer.connect("timeout",self,"flip")

func flip():
	dir = -dir
