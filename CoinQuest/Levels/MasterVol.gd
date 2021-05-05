extends HSlider

onready var slider = $"."

func _ready():
	slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))

func _on_MasterVol_value_changed(value):
	if value > -81:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)

