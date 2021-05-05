extends Node2D


onready var player = get_parent()
var lives = 0
export var is_following = true


func _ready():
	if is_following:
		$AnimationPlayer.play("Idle")
	else:
		pass


func _process(delta):
	if is_following:
		global_position.x = lerp(global_position.x, player.player_location.x, delta/2)
	else:
		pass


func attack():
	$AnimationPlayer.play("attack")


func hurt():
	if lives <= 0:
		is_following = false
		die()
	else:
		lives -= 1


func die():
	BgmPlayer.pause()
	$AnimationPlayer.play("Death")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		$AnimationPlayer.play("Idle")
		$RandomTimer.random_start()
		is_following = true
	elif anim_name == "wind_up":
		attack()
		is_following = false


func _on_RandomTimer_timeout():
	$AnimationPlayer.play("wind_up")
	
	
func _on_StartTimer_timeout():
	$AnimationPlayer.play("wind_up")
