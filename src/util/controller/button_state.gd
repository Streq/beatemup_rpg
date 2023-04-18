extends Reference
class_name ButtonState

var pressed := false setget set_pressed
var just_updated := false

func set_pressed(val:bool):
	just_updated = pressed!=val
	pressed = val
func press():
	set_pressed(true)
func release():
	set_pressed(false)

func is_just_pressed():
	return pressed and just_updated
func is_just_released():
	return !pressed and just_updated
func is_pressed():
	return pressed
func stale():
	just_updated = false

func copy_from(state: ButtonState):
	pressed = state.pressed
	just_updated = state.just_updated

func clear():
	pressed = false
	just_updated = false

func _to_string() -> String:
	return "(pressed:%s,just_updated:%s)" % [pressed,just_updated]
