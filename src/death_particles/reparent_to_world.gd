extends Node

#if 1, world == owner.get_parent()
#if 2, world == owner.owner.get_parent()
#etc
export var owner_ancestry_until_world := 1



func trigger():
	var _owner = owner
	for i in owner_ancestry_until_world-1:
		_owner = _owner.owner
		
	NodeUtils.reparent_keep_transform(get_parent(),_owner.get_parent())
