extends ReferenceRect



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()
	yield(RoomGlobal,"player_entered")
	setup()

func setup():
	var cameras = Group.get_all("player_camera")
	for camera in cameras:
		print("setting_camera_limits:", self.rect_global_position,self.rect_global_position+self.rect_size)
		camera.limit_left = self.rect_global_position.x
		camera.limit_top = self.rect_global_position.y
		camera.limit_right = self.rect_global_position.x+self.rect_size.x
		camera.limit_bottom = self.rect_global_position.y+self.rect_size.y
