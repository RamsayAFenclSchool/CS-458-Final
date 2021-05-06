extends CanvasLayer

export var start_chime = "res://SFX/jingles_NES03.ogg"

func _ready():
	$Sprite/AudioStreamPlayer.stream = load(start_chime)
	$Sprite/AudioStreamPlayer.play()
