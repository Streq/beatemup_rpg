extends CharacterState

onready var hitstun := owner.get_node("%hitstun")

func _physics_update(delta: float):
	if !hitstun.is_stunned():
		goto("air")
