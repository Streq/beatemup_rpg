extends Node

export var exclude : PoolStringArray
export var include : PoolStringArray


onready var matcher = RegexMatcher.new(include,exclude)

func check(string):
	print(string,":",matcher.check(string))

func _ready() -> void:
	check("chaw")
	check("hola")
	check("gil")
	check("idle")
