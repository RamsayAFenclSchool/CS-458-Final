extends Control

func _ready():
	if Global.bonusLevelCompleted && Global.bonusEffects:
		start_up()
	else:
		shut_down()

func start_up():
	visible = true
	$RadialSpawner.is_active = true
	$RadialSpawner2.is_active = true
	$RadialSpawner3.is_active = true

func shut_down():
	visible = false
	$RadialSpawner.is_active = false
	$RadialSpawner2.is_active = false
	$RadialSpawner3.is_active = false


func _on_EffectButton_toggled(button_pressed):
	if Global.bonusLevelCompleted:
		if button_pressed:
			start_up()
		else:
			shut_down()
