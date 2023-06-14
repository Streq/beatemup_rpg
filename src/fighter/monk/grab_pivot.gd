extends Node2D

var current = null


func grab(target):
	if is_instance_valid(current):
		drop()
	current = target
	NodeUtils.reparent(current, self)
	current.position = Vector2()

func drop():
	NodeUtils.reparent_keep_transform(current, owner.get_parent())
	current.rotation = 0
	current = null

func is_grabbing():
	return is_instance_valid(current)
