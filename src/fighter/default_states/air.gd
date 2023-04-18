extends CharacterState

func _physics_update(delta: float):
	if root.is_on_floor():
		goto("idle")
