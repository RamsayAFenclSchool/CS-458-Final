extends AudioStreamPlayer

onready var BGMplayer = $"."

var is_paused = false
var is_enabled = true

func playBGM(song : String):
	if is_enabled:
		is_paused = false
		var track = load(song)
		BGMplayer.stream = track
		BGMplayer.play()
		BGMplayer.set_stream_paused(false)

func pause():
	BGMplayer.set_stream_paused(true)
	is_paused = true

func resume():
	BGMplayer.set_stream_paused(false)
	is_paused = false
