extends ColorRect
tool

export var palette : PoolColorArray

var tex = ImageTexture.new()


var ready = false

func set_palette(val):
	palette = val
	if ready:
		update_tex_from_palette()
		
		material.set_shader_param("palette_size", palette.size())
#		_set_string_val()
		property_list_changed_notify()

func update_tex_from_palette():
	var size = palette.size()
	if size:
		var img = Image.new()
		img.create(size, 1, false, Image.FORMAT_RGBA8)
		img.lock()
		for i in size:
			img.set_pixel(i%size, i/size, palette[i])
		img.unlock()
		update_tex(img)
	
func update_tex(img):
	tex.flags = -1
	tex.create_from_image(img)
	tex.flags = 0
	material.set_shader_param("palette", tex)


func _ready():
	
	ready = true
	set_palette(palette)
#	shader_offset = material.get_shader_param("offset")
#	material.set_shader_param("palette", tex)
#	material.set_shader_param("palette_size", palette.size())
#	update_parent_material()
#	set_glow(glow)
