extends HSlider

onready var slider = $"."

func _ready():
	slider.value = SfxPlayer.get_volume_db()

func _on_EffectVol_value_changed(value):
	if value > -81:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
		SfxPlayer.set_volume_db(value)
		SfxPlayer.is_enabled = true
	else:
		SfxPlayer.is_enabled = false



func _on_MasterVol_value_changed(value):
	if value > -81:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)

