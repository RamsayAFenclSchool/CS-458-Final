extends AudioStreamPlayer

onready var SFXplayer = $"."

var is_enabled = true

func playSFX(effect : String):
	if is_enabled:
		var track = load(effect)
		SFXplayer.stream = track
		SFXplayer.play()
