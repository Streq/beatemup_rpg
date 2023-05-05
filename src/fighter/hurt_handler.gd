extends Node
onready var fighter : Fighter = owner as Fighter
func _ready() -> void:
	owner.connect("hurt",self,"hurt")
	
func hurt():
	fighter.state_machine.current.goto("hurt")
