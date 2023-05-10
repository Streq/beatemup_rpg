extends Area2D

export var active := true setget set_active

export var damage := 10.0
export var knockback := Vector2(100,-50)
export var touch_level := 1
export var knockback_horizontal_away_from := false

func set_active(val):
	active = val
	set_deferred("monitorable",active)
	set_deferred("monitoring",active)


func _on_area_entered(hurtbox):
	var target = hurtbox.owner
	if (owner == target or 
		owner.team == target.team or
		target.hitbox_touch_level > touch_level
		):
		return
	var caster = owner
	
	notify_hit(target)

	var hitstop_frames = calculate_hitstop_frames(damage, knockback)
	apply_hitstop(owner, hitstop_frames/2)
	apply_hitstop(target, hitstop_frames)
	apply_shake(target, hitstop_frames)

	apply_damage(target)
	apply_knockback(target)

	var hitstun_frames = calculate_hitstun_frames(damage, knockback)
	apply_hitstun(target, hitstun_frames)


func calculate_hitstop_frames(damage, knockback):
	return 12
func calculate_hitstun_frames(damage, knockback):
	return 24

func apply_damage(target):
	target.health.value -= damage

func apply_knockback(target):
	var sign_x 
	if knockback_horizontal_away_from:
		sign_x = sign(target.global_position.x-owner.global_position.x)
	else:
		sign_x = owner.facing_dir
	
	target.velocity = Vector2(knockback.x*sign_x, knockback.y)
	target.facing_dir = -sign_x

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
