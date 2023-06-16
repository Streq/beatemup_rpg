extends CharacterState
onready var grab_pivot: Node2D = $"%grab_pivot"

func throw():
	var thrown = grab_pivot.drop()
	if !is_instance_valid(thrown):
		return
	thrown.stun("throw_stun",60)
	thrown.velocity.x = root.facing_dir*200.0
	thrown.velocity.y = root.velocity.y
	
func _physics_update(delta: float):
	var acceleration = (
		root.horizontal_decceleration
		if root.grounded else
		root.horizontal_air_decceleration
	)
	root.velocity.x = move_toward(
		root.velocity.x, 
		0, 
		acceleration * delta
	)
