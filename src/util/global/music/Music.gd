extends Node

var song_map = {}
onready var songs: Node = $songs
onready var player: AudioStreamPlayer = $player

func _ready() -> void:
	for song in songs.get_children():
		song_map[song.name] = load(song.stream)
		song.queue_free()
func play(song:String, from:float)->void:
	player.stream = song_map[song]
	player.play(from)

func stop():
	player.stop()
