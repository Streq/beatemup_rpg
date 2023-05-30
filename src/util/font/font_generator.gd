extends Label
tool

var bitmap_font : BitmapFont

export (String, FILE) var font_texture_path
export (String, MULTILINE) var reference_string := "abcdefghijklmnopqrstuvwxyz"
export var output_font := "res://BitmapFont.res"

export var width = 8
export var height = 8
export var columns = 32

export var run = false setget run

func run(val):
	execute()

func execute():
	bitmap_font = BitmapFont.new()
	bitmap_font.add_texture(load(font_texture_path))
	bitmap_font.height = height
	
	var i = 0
	var j = 0
	
	for c in reference_string:
		if c == "\n":
			j += 1
			i = 0
			continue
		bitmap_font.add_char(ord(c), 0, get_glyph_rect(i,j))
		i += 1
	theme = Theme.new()
	theme.default_font = bitmap_font


	if(ResourceSaver.save(output_font, bitmap_font) == OK):
		theme = Theme.new()
		theme.default_font = load(output_font)

func get_glyph_rect(i, j) -> Rect2:
	return Rect2(i * width, j * height, width, height)
