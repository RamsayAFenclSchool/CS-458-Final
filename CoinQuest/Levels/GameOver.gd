extends Control

func _ready():
	print("saved")
	Global.save()


func _on_RestartButton_pressed():
	get_tree().change_scene(Global.lastScene)

