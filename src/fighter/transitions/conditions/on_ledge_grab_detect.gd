extends Node

export var ledge_detect_path : NodePath 
onready var ledge_detect: Node2D = get_node(ledge_detect_path)
export var y_velocity_has_to_be_higher_than := -10.0



func check():
	return ledge_detect.has_ledge() and owner.velocity.y>y_velocity_has_to_be_higher_than
