extends Area2D
signal grab_entered(target)
export var active := true setget set_active


func set_active(val):
	active = val
	set_deferred("visible", active)
	set_deferred("monitorable", active)
	set_deferred("monitoring", active)


func _on_area_entered(hurtbox):
	var target = hurtbox.owner
	if owner == target or owner.team == target.team:
		return
	var caster = owner
	emit_signal("grab_entered", target)


func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")
