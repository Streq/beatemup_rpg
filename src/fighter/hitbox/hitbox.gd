extends Area2D

export var active := true setget set_active
func set_active(val):
	active = val
	monitorable = active
	monitoring = active


func _on_area_entered(hurtbox):
	if owner == hurtbox.owner or owner.team == hurtbox.owner.team:
		return
	var target = hurtbox.owner
	target.velocity = Vector2(owner.facing_dir*100.0, -50.0)
	target.health.value -= 10.0
	target.facing_dir = -owner.facing_dir

func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
