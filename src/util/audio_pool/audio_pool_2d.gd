extends AudioStreamPlayer2D
export var pool_size := 10

var index = 0
export var cooldown := 0.0166667
var seconds_since_last_call = 1000.0

var pool := []
func _ready() -> void:
	for i in pool_size:
		var sound = duplicate(0)
		pool.append(sound)
	
	for sound in pool:
		add_child(sound)
		


func play_at_position(play_global_position := Vector2()):
	
	if seconds_since_last_call<cooldown:
		return
	seconds_since_last_call = 0.0
	var sound : AudioStreamPlayer2D = get_child(index)
	sound.global_position = play_global_position
	sound.play()
	
	index = (index+1)%pool_size

func _physics_process(delta: float) -> void:
	seconds_since_last_call+=delta
