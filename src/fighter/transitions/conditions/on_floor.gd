extends Node


export var should_be_on_floor := false


func check():
	return owner.grounded == should_be_on_floor
