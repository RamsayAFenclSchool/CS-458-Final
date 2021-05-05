extends "res://Levels/GameOver.gd"

func _ready():
	if Global.bonusLevelUnlocked && !Global.bonusLevelCompleted:
		BgmPlayer.pause()
		$Label/AnimationPlayer.play("Unlocking")
		SfxPlayer.playSFX("res://SFX/jingles_NES05.ogg")


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	$Label/AnimationPlayer.play("Unlocked")
	BgmPlayer.resume()
