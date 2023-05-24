extends Node
onready var door_detect: Area2D = $"%door_detect"


func check():
	return !door_detect.get_overlapping_areas().empty()
