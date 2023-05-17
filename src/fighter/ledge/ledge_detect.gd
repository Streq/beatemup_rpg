extends Node2D


onready var floor_detect: RayCast2D = $"%floor_detect"
onready var wall_detect: RayCast2D = $"%wall_detect"
onready var gap_detect: RayCast2D = $"%gap_detect"

var has_ledge := false
var ledge := Vector2()

func _physics_process(delta: float) -> void:
	has_ledge = false
	if !floor_detect.is_colliding() or !wall_detect.is_colliding() or gap_detect.is_colliding():
		return 
	var floor_point = floor_detect.get_collision_point()
	var wall_point = wall_detect.get_collision_point()
	has_ledge = true
	ledge = Vector2(wall_detect.get_collision_point().x, floor_point.y)
