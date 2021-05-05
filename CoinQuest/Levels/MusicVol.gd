extends HSlider

onready var slider = $"."

func _ready():
	if BgmPlayer.is_enabled:
		slider.value = BgmPlayer.get_volume_db()
	else:
		slider.value = -90

func _on_MusicVol_value_changed(value):
	if value > -81:
		BgmPlayer.set_volume_db(value)
		BgmPlayer.is_enabled = true
		if BgmPlayer.is_paused:
			BgmPlayer.resume()
	else:
		if BgmPlayer.is_playing():
			BgmPlayer.pause()
		BgmPlayer.is_enabled = false

