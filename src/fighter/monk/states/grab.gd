extends CharacterState
onready var grabbox: Area2D = $"%grabbox"
onready var grab_pivot: Node2D = $"%grab_pivot"

func _enter(params):
	grabbox.connect("grab_entered",self,"_on_grab_entered")

func _exit():
	grabbox.disconnect("grab_entered",self,"_on_grab_entered")

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

func _on_grab_entered(target):
	target.state_machine.current.goto("grabbed")
	grab_pivot.call_deferred("grab",target)
	goto("grab_successful")
	
