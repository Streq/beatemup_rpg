extends CharacterState

onready var hitstun := owner.get_node("%hitstun")
onready var dead_free_anim: Node = $"%dead_free_anim"

func _physics_update(delta: float):
	if !hitstun.is_stunned():
		goto("air")
	if root.is_on_floor() or root.is_on_wall() or root.is_on_ceiling():
		print (root.health.value)
		root.health.value -= 2
		if root.health.empty():
			dead_free_anim.play()
			
		root.freeze(5)
		root.shake(5)
		root.hitstun(1)
		if root.is_on_floor():
			root.velocity = root.previous_frame_velocity.bounce(root.get_floor_normal())*0.9
			
