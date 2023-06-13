extends CPUParticles2D

signal trigger()

var velocity := Vector2()

func _physics_process(delta: float) -> void:
	global_position += velocity*delta

var fighter

func _ready() -> void:
	set_physics_process(false)
	fighter = owner
func trigger():
	set_physics_process(true)
	velocity = fighter.velocity
	emit_signal("trigger")
	
func stop_moving():
	set_physics_process(false)
