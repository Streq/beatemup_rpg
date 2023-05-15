extends Node

onready var input_buffer = owner.get_node("%input_buffer")

export var sequence := ""
var mirror := ""

func _ready() -> void:
	mirror = sequence
	for i in mirror.length():
		var character = mirror[i]
		match character:
			"1":
				mirror[i] = "3"
			"3":
				mirror[i] = "1"
			"4":
				mirror[i] = "6"
			"6":
				mirror[i] = "4"
			"7":
				mirror[i] = "9"
			"9":
				mirror[i] = "7"


func check():
	return (
		input_buffer.is_latest and
		(
			(owner.facing_dir>0 and input_buffer.buffer.ends_with(sequence)) or
			(owner.facing_dir<0 and input_buffer.buffer.ends_with(mirror))
		)
	)
