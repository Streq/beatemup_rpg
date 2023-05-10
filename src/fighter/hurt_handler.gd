extends Node
#onready var fighter : Fighter = owner as Fighter
#func _ready() -> void:
#	owner.connect("hurt",self,"hurt")
#	owner.connect("flinch",self,"flinch")
#
#func hurt():
#	fighter.state_machine.current.goto("hurt")
#
#func flinch(frames):
#	fighter.state_machine.current.goto("hurt")
