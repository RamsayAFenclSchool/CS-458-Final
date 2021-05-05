extends Node2D

var speed = 100
onready var player = get_parent()
var lives = 0

func _process(delta):
	global_position.x = lerp(global_position.x, player.player_location.x, delta)

func hurt():
	if lives <= 0:
		die()
	else:
		lives -= 1

func die():
	BgmPlayer.pause()
	$PlayerLocation/Player.free()
	$AnimationPlayer.play("Death")
