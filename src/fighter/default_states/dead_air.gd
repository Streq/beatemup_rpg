extends CharacterState
onready var terrain_collision: CollisionShape2D = $"%terrain_collision"

var frames := 0

func _enter(params):
	terrain_collision.set_deferred("disabled", true)
	frames = 0
	pass

func _physics_update(delta: float):
	frames += 1
	
	if frames > 22:
		goto("dead")
		return
	if frames > 19:
		root.velocity = Vector2()
		return
		
	root.velocity*=1-delta*1.0
#	var acceleration = (
#		root.horizontal_decceleration
#		if root.grounded else
#		root.horizontal_air_decceleration
#	)
#	root.velocity.x = move_toward(
#		root.velocity.x, 
#		0, 
#		acceleration * delta
#	)
#	if root.grounded:
#		goto("dead")
#		return
