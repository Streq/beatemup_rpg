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
	var caster = owner
	
	notify_hit(target)

	var hitstop_frames = calculate_hitstop_frames(damage, knockback)
	apply_hitstop(owner, hitstop_frames)
	apply_hitstop(target, hitstop_frames)
	apply_shake(target, hitstop_frames)

	apply_damage(target)
	apply_knockback(target)

	var hitstun_frames = calculate_hitstun_frames(damage, knockback)
	apply_hitstun(target, hitstun_frames)


func calculate_hitstop_frames(damage, knockback):
	return 10
func calculate_hitstun_frames(damage, knockback):
	return 20

func apply_damage(target):
	target.health.value -= damage

func apply_knockback(target):
	target.velocity = Vector2(owner.facing_dir*knockback.x, knockback.y)
	target.facing_dir = -owner.facing_dir

func apply_hitstun(target, frames):
	target.hitstun(frames)

func apply_hitstop(target, frames):
	target.freeze(frames)

func notify_hit(target):
#	target.get_hurt()
	pass

func apply_shake(target,frames):
	target.shake(frames)
	pass

func _ready() -> void:
	connect("area_entered",self,"_on_area_entered")
