extends Node
class_name Bar
signal value_changed(value, max_value)
signal empty
signal full
signal not_full

export var max_value := 100.0 setget set_max_value
export var value := 100.0 setget set_value

func set_value(val):
	var aux_value = value
	value = clamp(val, 0, max_value)
#	if aux_value == value:
#		return
	emit_signal("value_changed", value, max_value)
	if aux_value == max_value and value != max_value:
		emit_signal("not_full")
	if !value:
		emit_signal("empty")
	if value == max_value:
		emit_signal("full")
func set_max_value(val):
	max_value = val
	set_value(value)


func _ready() -> void:
	set_value(value)

func is_full():
	return value == max_value

func fill() -> void:
	set_value(max_value)

func empty():
	return value == 0.0
