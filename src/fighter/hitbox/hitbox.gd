extends Area2D

export var active := true setget set_active
func set_active(val):
	active = val
	monitorable = active
	monitoring = active


func _on_area_entered(hurtbox):
	if owner == hurtbox.owner:
		return
	hurtbox.owner.velocity = Vector2(owner.facing_dir*100.0, -50.0)
	hurtbox.owner.health.value -= 10.0
func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
