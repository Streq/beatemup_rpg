extends ReferenceRect


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var camera : Camera2D = Group.get_one("player_camera")
	camera.limit_left = self.rect_global_position.x
	camera.limit_top = self.rect_global_position.y
	camera.limit_right = self.rect_global_position.x+self.rect_size.x
	camera.limit_bottom = self.rect_global_position.y+self.rect_size.y
