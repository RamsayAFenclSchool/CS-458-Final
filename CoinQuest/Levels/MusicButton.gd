extends TextureButton

onready var button = $"."

var track = "res://SFX/Chiptune_Adventures_1.ogg"

func _ready():
	BgmPlayer.is_paused = false

func _on_PlayButton_toggled(button_pressed):
	if button_pressed:
		if BgmPlayer.is_paused == false:
			BgmPlayer.playBGM(track)
		else:
			BgmPlayer.resume()
	else:
		BgmPlayer.pause()
