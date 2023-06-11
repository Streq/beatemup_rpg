extends Node
var played = false
onready var death_particles: CPUParticles2D = $"%death_particles"

func play():
	if played:
		return
	played = true
	get_node("%hurtbox").queue_free()
	get_node("%hitbox").queue_free()
#	var tween = create_tween()
#	tween.tween_property(owner,"visible",false, 0.1)
#	tween.tween_property(owner,"visible",true, 0.1)
#	tween.set_loops(5)
#	yield(tween,"finished")
	death_particles.trigger()
	owner.despawn()
