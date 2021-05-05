extends Node2D

export (int) var level
export (int) var score_req
export (String) var BGM
export (String) var combo_sound = "res://SFX/UI/combo.ogg"
export (String) var loser_sound = "res://SFX/UI/loser.ogg"
export (String) var winner_sound = "res://SFX/UI/winner.ogg"
export (String) var score_sound = "res://SFX/UI/flawless_victory.ogg"

var lives = 3
var coins = 0
var coin_target = 20

func _ready():
	prep_death()
	BgmPlayer.playBGM(BGM)
	update_GUI()
	add_to_group("Gamestate")

func hurt():
	if get_node_or_null("PlayerLocation/Player") != null && not $PlayerLocation/Player.is_invincible:
		if lives <= 0:
			die()
		else:
			lives -= 1
			$PlayerLocation/Player.hurt()
			update_GUI()
		print(lives)

func add_coin():
	coins += 1
	update_GUI()
	var multiple_of_coins = (coins % coin_target) == 0
	if multiple_of_coins:
		add_life()

func add_life():
	SfxPlayer.playSFX(combo_sound)
	lives += 1
	update_GUI()

func update_GUI():
	get_tree().call_group("GUI","update_GUI", lives, coins)

func prep_death():
	$Death.visible = false
	$Death.modulate = $PlayerLocation/Player/PlayerAnimation.modulate

func die():
	$PlayerLocation.camera_follow = false
	BgmPlayer.pause()
	$Death.global_position = $PlayerLocation/Player.global_position
	$PlayerLocation/Player.visible = false
	$PlayerLocation/Player.free()
	$Death.visible = true
	$Death/AnimationPlayer.play("Death")

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	#$PlayerLocation/Camera2D2/Recorder.save_frames(null)
	end_game()
	
func end_game():
	SfxPlayer.playSFX(loser_sound)
	BgmPlayer.playBGM("res://SFX/Chiptune_Adventures_1.ogg")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Levels/GameOver.tscn")

func win_game():
	if level > Global.levelCompleted && level < Global.bonusLevelCheck.size():
		Global.levelCompleted = level
	if Global.curScene == "res://Levels/bonusLevel.tscn":
		Global.bonusLevelCompleted = true
	elif coins >= score_req:
		Global.levelScoreMet[level] = true
		Global.bonusLevelCheck[level-1] = true
		SfxPlayer.playSFX(score_sound)
	else:
		SfxPlayer.playSFX(winner_sound)
	BgmPlayer.playBGM("res://SFX/Chiptune_Adventures_1.ogg")
	Global.bonusLevelUnlocked = bonus_level_check()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Levels/Victory.tscn")
	

func bonus_level_check():
	for i in Global.bonusLevelCheck:
		if i == false:
			return false
		else:
			pass
	return true
