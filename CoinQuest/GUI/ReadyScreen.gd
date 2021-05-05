extends CanvasLayer

export var start_chime = "res://SFX/UI/prepare_yourself.ogg"

func _ready():
	$Sprite/AudioStreamPlayer.stream = load(start_chime)
	$Sprite/AudioStreamPlayer.play()
