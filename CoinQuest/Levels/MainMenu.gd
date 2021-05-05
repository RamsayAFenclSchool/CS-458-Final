extends Control

func _ready():
	if Global.load_save():
		Global.bonusEffects = Global.sav.bonusEffects
		Global.bonusLevelCheck = Global.sav.bonusLevelCheck
		Global.bonusLevelCompleted = Global.sav.bonusLevelCompleted
		Global.bonusLevelUnlocked = Global.sav.bonusLevelUnlocked
		Global.levelScoreMet = Global.sav.levelScoreMet
		Global.levelCompleted = Global.sav.levelCompleted
	if Global.bonusEffects && Global.bonusLevelCompleted:
		$Node2D/Particles2D.visible = true
		$Node2D/PlayerAnimation.modulate = Color(1,.7,.5)
		$Node.start_up()
	Engine.set_target_fps(Engine.get_iterations_per_second())
	if BgmPlayer.is_paused || BgmPlayer.get_stream() != load("res://SFX/BGM/POL-pet-park-short.wav"):
		BgmPlayer.playBGM("res://SFX/BGM/POL-pet-park-short.wav")
	else:
		BgmPlayer.resume()
