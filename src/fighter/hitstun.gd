extends Node


export var frames := 0

func is_stunned():
	return frames > 0

func hitstun(stun_frames):
	frames = stun_frames
	if frames>0:
		owner.state_machine.current.goto("hurt")

func stun(state, stun_frames):
	frames = stun_frames
	if frames>0:
		owner.state_machine.current.goto(state)

func _ready():
	owner.connect("hitstun",self,"hitstun")
	owner.connect("stun",self,"stun")
	owner.connect("frame",self,"frame")

func frame(delta):
	frames = max(frames-1, 0)
