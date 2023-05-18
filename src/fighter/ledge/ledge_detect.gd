extends Node2D


onready var floor_detect: RayCast2D = $"%floor_detect"
onready var wall_detect: RayCast2D = $"%wall_detect"
onready var gap_detect: RayCast2D = $"%gap_detect"

var _has_ledge := false
var _ledge := Vector2()
var _dirty = false

func _physics_process(delta: float) -> void:
	_dirty = true

func has_ledge():
	if _dirty:
		force_update()
	return _has_ledge

func get_ledge():
	if _dirty:
		force_update()
	return _ledge


func force_update():
	_dirty = false
	floor_detect.force_raycast_update()
	wall_detect.force_raycast_update()
	gap_detect.force_raycast_update()
	_has_ledge = false
	if !floor_detect.is_colliding() or !wall_detect.is_colliding() or gap_detect.is_colliding():
		return 
	var floor_point = floor_detect.get_collision_point()
	var wall_point = wall_detect.get_collision_point()
	_has_ledge = true
	_ledge = Vector2(wall_detect.get_collision_point().x, floor_point.y)

