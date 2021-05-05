extends Control

func _ready():
	if BgmPlayer.is_paused || BgmPlayer.get_stream() != load("res://SFX/BGM/POL-jazzy-duck-short.wav"):
		BgmPlayer.playBGM("res://SFX/BGM/POL-jazzy-duck-short.wav")
	else:
		BgmPlayer.resume()
