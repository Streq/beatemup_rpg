extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var arr = [1,2,3,4,5,6]
	var max_value = 3
	for i in max_value:
		print("previous to max_value:",arr[i])
	for i in arr.size()-max_value:
		print("post max_value:",arr[max_value+i])
