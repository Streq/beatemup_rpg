extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	var sas = [1,2,3]
#	modify_array(sas)
#	print(sas)
#	for c in "    ".split(" ",false):
#		print("\"",c,"\"")
#	print(" ".join(["hola soy santi","capo"]))
#
	var o = []
	o.resize(4)
	o[3] = "sus"
	print(o)
func modify_array(a:Array):
	a.remove(0)
