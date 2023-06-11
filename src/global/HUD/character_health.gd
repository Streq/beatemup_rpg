extends HBoxContainer
onready var bar: PanelContainer = $bar
onready var avatar: TextureRect = $avatar

var current_fighter : Fighter = null

func track_soft(fighter:Fighter):
	if current_fighter:
		return
	track(fighter)


func track(fighter:Fighter):
	untrack()
	
	current_fighter = fighter
	if !is_instance_valid(current_fighter):
		return
	var health = fighter.health
	health.connect("value_changed", self, "on_health_changed")
	fighter.connect("despawned", self, "untrack")
	bar.show()
	avatar.show()
	on_health_changed(health.value,health.max_value)


func untrack():
	if is_instance_valid(current_fighter):
		current_fighter.health.disconnect("value_changed",self,"on_health_changed")
		current_fighter.disconnect("despawned",self,"untrack")
	current_fighter = null
	bar.hide()
	avatar.hide()

func _ready() -> void:
	untrack()
	
func on_health_changed(value,max_value):
	bar.set_max_value(max_value)
	bar.set_value(value)

