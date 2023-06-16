extends Node2D

var current = null


func grab(target):
	drop()
	current = target
	NodeUtils.reparent(current, self)
	current.position = Vector2()

func drop():
	var ret = null
	if is_instance_valid(current):
		NodeUtils.reparent_keep_transform(current, owner.get_parent())
		current.rotation = 0
		current.scale = Vector2(1,1)
		current.state_machine.current.goto("air")
		ret = current
		current = null
	return ret
func is_grabbing():
	return is_instance_valid(current)
