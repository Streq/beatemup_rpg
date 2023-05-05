extends Area2D

export var active := true setget set_active

export var damage := 10.0
export var knockback := Vector2(100,-50)


func set_active(val):
	active = val
	monitorable = active
	monitoring = active


func _on_area_entered(hurtbox):
	if owner == hurtbox.owner or owner.team == hurtbox.owner.team:
		return
	var target = hurtbox.owner
	target.velocity = Vector2(owner.facing_dir*knockback.x, knockback.y)
	target.health.value -= damage
	target.facing_dir = -owner.facing_dir
	target.get_hurt()
func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
