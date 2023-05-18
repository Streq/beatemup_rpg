extends State
class_name CharacterState

signal pre_enter()

export var animation := ""
export var change_on_animation_finish := true
export var on_finish_goto_state := ""

export var is_dead_state := false

func enter(params):
	emit_signal("pre_enter")
	root.state_animation.play("RESET")
	root.state_animation.advance(0.0)
	root.state_animation.play(animation)
	root.state_animation.advance(0.0)
	root.state_animation.connect("animation_finished", self, "_on_animation_finished")
	.enter(params)

func exit():
	root.state_animation.disconnect("animation_finished", self, "_on_animation_finished")
	.exit()


func _on_animation_finished(name):
	if change_on_animation_finish and on_finish_goto_state:
		goto(on_finish_goto_state)

