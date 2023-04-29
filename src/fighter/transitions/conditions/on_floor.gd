extends Node


export var should_be_on_floor := false


func check():
	return owner.is_on_floor() == should_be_on_floor
