extends Control

func _ready():
	if Global.bonusLevelUnlocked:
		$LevelButton2.visible = true
	else:
		$LevelButton2.visible = false
	if Global.bonusLevelCompleted:
		$EffectButton.visible = true
	else:
		$EffectButton.visible = false
	if Global.bonusEffects:
		$EffectButton.pressed = true
	else:
		$EffectButton.pressed = false
