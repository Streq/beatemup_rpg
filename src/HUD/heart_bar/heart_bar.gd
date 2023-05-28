extends PanelContainer
tool
export var HEART : PackedScene = preload("heart.tscn")

onready var bar: HBoxContainer = $"%bar"

export var MAX_HEARTS : int = 8 setget set_max_hearts
export var HEALTH_PER_HEART : int = 4

export var max_value : int = 12 setget set_max_value
export var value : int = 12 setget set_value


func set_max_value(val):
	max_value = clamp(val, 0, MAX_HEARTS*HEALTH_PER_HEART)
	if bar:
		update_visible_hearts()
	set_value(value)
	

func update_visible_hearts():
	var heart_count : int = max_value/HEALTH_PER_HEART

	var hearts = bar.get_children()
	for i in heart_count:
		hearts[i].capacity = 4
	for i in MAX_HEARTS-heart_count:
		hearts[heart_count+i].capacity = 0
	var remainder = max_value%HEALTH_PER_HEART
	if remainder:
		hearts[heart_count].capacity = remainder 
	
func set_value(val):
	value = clamp(val, 0, max_value)
	if bar:
		update_heart_progress()

func update_heart_progress():
	var hearts = bar.get_children()
	var total_hearts = max_value/HEALTH_PER_HEART+int((max_value%HEALTH_PER_HEART)!=0)
	var full_hearts = value/HEALTH_PER_HEART
	
	for i in full_hearts:
		hearts[i].fill()

	var empty_hearts = total_hearts-full_hearts
	for i in empty_hearts:
		hearts[full_hearts+i].empty()

	var last_heart_progress = value%HEALTH_PER_HEART
	if last_heart_progress:
		hearts[full_hearts].progress = last_heart_progress


	
	

func set_max_hearts(val):
	MAX_HEARTS = val
	if bar:
		update_max_hearts()
	
	set_max_value(max_value)

func update_max_hearts():
	var current_hearts = bar.get_child_count()
	
	while current_hearts < MAX_HEARTS:
		current_hearts += 1
		var heart = HEART.instance()
		bar.add_child(heart)
		
	while current_hearts > MAX_HEARTS:
		current_hearts -= 1
		var heart = bar.get_child(current_hearts-1)
		heart.queue_free()

func _ready() -> void:
	set_max_hearts(MAX_HEARTS)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		set_value(value-1)
	if event.is_action_pressed("B"):
		set_value(value+1)
	if event.is_action_pressed("L"):
		set_max_value(max_value-1)
	if event.is_action_pressed("R"):
		set_max_value(max_value+1)
	if event.is_action_pressed("X"):
		set_max_hearts(MAX_HEARTS-1)
	if event.is_action_pressed("Y"):
		set_max_hearts(MAX_HEARTS+1)
	
