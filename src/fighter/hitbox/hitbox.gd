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
	apply_knockback(target)
	apply_damage(target)
	apply_hitstun(target)
	stun_caster()



func apply_damage(target):
	target.health.value -= damage
func apply_knockback(target):
	target.velocity = Vector2(owner.facing_dir*knockback.x, knockback.y)
	target.facing_dir = -owner.facing_dir
func apply_hitstun(target):
	target.get_hurt()
func stun_caster():
	pass

func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
