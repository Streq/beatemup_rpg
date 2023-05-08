extends Node


export var frames := 0

func is_stunned():
	return frames > 0

func hitstun(stun_frames):
	frames = stun_frames
	if frames:
		owner.state_machine.current.goto("hurt")

func _ready():
	owner.connect("hitstun",self,"hitstun")
	owner.connect("frame",self,"frame")

func frame(delta):
	frames = max(frames-1, 0)
