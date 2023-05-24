extends Node

export var buffer_size = 300

onready var buffer = CircularBuffer.new(buffer_size)

var mutex = Mutex.new()
var thread

func _process(delta: float) -> void:
#	print(OS.get_user_data_dir())
	var result = mutex.try_lock()
	if result:
		return
	var image = get_viewport().get_texture().get_data()
	
	buffer.push_back(image)
	
	
	
	mutex.unlock()
	
	if Input.is_action_just_pressed("record"):
		
		thread = Thread.new()
		thread.start(self, "save_frames")
		

func save_frames():
	mutex.lock()
	
	print("started saving recording")
	var dimensions = get_viewport().size
	
	
	var dir = Directory.new()
	dir.open("user://")
	var dir_name = Time.get_datetime_string_from_system()
	dir.make_dir(dir_name)
	
	var img = Image.new()
	var size = buffer.size
	
	var file_number_padding = str(size).length()
	
	var format = "%0"+str(file_number_padding)+"d.png"
	
	for i in size:
		print("processing frame ", i)
		img = buffer.at(i)
		img.flip_y()
		
		img.save_png("user://" + dir_name.plus_file(format%i))
	
	print("done saving recording")
	mutex.unlock()
	return


func _ready() -> void:
	if !OS.is_debug_build():
		queue_free()
