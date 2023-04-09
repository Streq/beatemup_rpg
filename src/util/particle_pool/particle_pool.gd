extends CPUParticles2D

export var pool_size := 100

var pool := []
var index := 0

func _ready() -> void:
	for i in pool_size:
		var instance = duplicate(0)
		pool.append(instance)
	
	for instance in pool:
		add_child(instance)
		

func play_at_position(global_pos) -> CPUParticles2D:
	index = (index+1)%pool_size
	
	var particles = pool[index]
	particles.restart()
	particles.global_position = global_pos
	return particles
