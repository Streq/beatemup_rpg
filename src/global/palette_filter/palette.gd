extends Node
tool


export var colors : PoolColorArray = PoolColorArray(default()) setget set_colors
export var enabled := true
export var string_val : String setget set_string_val

#For multiedit purposes
export var color0 : Color setget set_color0, get_color0
func set_color0(val):
	colors[0] = val
func get_color0():
	return colors[0]

export var color1 : Color setget set_color1, get_color1
func set_color1(val):
	colors[1] = val
func get_color1():
	return colors[1]

export var color2 : Color setget set_color2, get_color2
func set_color2(val):
	colors[2] = val
func get_color2():
	return colors[2]

export var color3 : Color setget set_color3, get_color3
func set_color3(val):
	colors[3] = val
func get_color3():
	return colors[3]


static func default():
	var ret = []
	ret.resize(4)
	ret.fill(Color.black)
	return ret


func set_string_val(val):
	var json = parse_json(val)
	var res = []
	
	for color in json:
		res.append(Color(color))
#		print(color)
	colors = PoolColorArray(res)
	string_val = val

func set_colors(val):
	colors = val
	_set_string_val()

func _set_string_val():
	var ret = []
	for color in colors:
		ret.append(color.to_html(true))
	string_val = to_json(ret)


func _ready() -> void:
	if !enabled and !Engine.editor_hint:
		queue_free()
		pass
