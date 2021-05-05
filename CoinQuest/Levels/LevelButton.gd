extends TextureButton

export (String) var button_text
export (String) var linked_level
export (int) var access_req
export (bool) var enabled
export (bool) var score_met
export (String) var sound_effect = ""

export (Texture) var blocked_texture
export (Texture) var open_texture
export (Texture) var clicked_texture

onready var level_label = $Label
onready var button = $"."
onready var medal = $Label/TextureRect

func _ready():
	setup()

func setup():
	level_label.text = button_text
	if access_req <= Global.levelCompleted:
		button.texture_normal = open_texture
		button.texture_pressed = clicked_texture
	else:
		button.disabled = true
		button.texture_normal = blocked_texture
	setMedal()
	if score_met:
		medal.visible = true

func setMedal():
	var num = button_text.to_int()
	if num > 0 && num <=6:
		score_met = Global.levelScoreMet[num]
	

func _on_LevelButton_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
	if linked_level == "lastScene":
		var temp = Global.curScene
		Global.curScene = Global.lastScene
# warning-ignore:return_value_discarded
		get_tree().change_scene(Global.lastScene)
		Global.lastScene = temp
	elif linked_level == "curScene":
# warning-ignore:return_value_discarded
		get_tree().change_scene(Global.curScene)
	else:
		Global.lastScene = Global.curScene
		Global.curScene = linked_level
# warning-ignore:return_value_discarded
		get_tree().change_scene(linked_level)
	if BgmPlayer.is_playing():
			BgmPlayer.pause()
	if sound_effect != "":
		SfxPlayer.playSFX(sound_effect)
	Global.save()
	print(Global.lastScene, "|||")
