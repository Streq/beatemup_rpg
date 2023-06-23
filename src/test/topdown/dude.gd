extends Node2D
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var sprite: Sprite = $Sprite

signal step_finished()

onready var grid = get_parent()

var moving = false

func _physics_process(delta: float) -> void:
	if moving:
		return
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	var step = Vector2(
		sign(direction.x), sign(direction.y) if !direction.x else 0.0
	)

	if !grid.attempt_move(self, step):
		var anim = "idle"
		match animation_player.current_animation:
			"walk_side":
				anim = "idle_side"
			"walk_back":
				anim = "idle_back"
			"walk_front":
				anim = "idle_front"
		animation_player.play(anim)
		return
	match step:
		Vector2.RIGHT:
			animation_player.play("walk_side")
			sprite.flip_h = false
		Vector2.LEFT:
			animation_player.play("walk_side")
			sprite.flip_h = true
		Vector2.DOWN:
			animation_player.play("walk_front")
			sprite.flip_h = false
		Vector2.UP:
			animation_player.play("walk_back")
			sprite.flip_h = false
		Vector2.ZERO:
			var anim = "idle"
			match animation_player.current_animation:
				"walk_side":
					anim = "idle_side"
				"walk_back":
					anim = "idle_back"
				"walk_front":
					anim = "idle_front"
			animation_player.play(anim)
		
	if !step:
		return
	moving = true
	yield(get_tree().create_timer(0.25),"timeout")
	emit_signal("step_finished")
	moving = false
