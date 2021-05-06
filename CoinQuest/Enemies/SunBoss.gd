extends Node2D


onready var player = get_parent()
var lives = 0
export var is_following = true
var spacing = 720.723
var is_dying = false

func _ready():
	#spacing = global_position.y
	global_position.y = -2000.00
	is_following = false
	BgmPlayer.pause()
	$StartTimer.start()


func _process(delta):
	if is_following:
		global_position.x = lerp(global_position.x, player.player_location.x, delta/2)
		if player.player_location.y < 0:
			global_position.y = lerp(global_position.y, player.player_location.y - 450, delta)
		else:
			global_position.y = lerp(global_position.y, spacing, delta)
	elif is_dying:
		global_position.y = lerp(global_position.y, global_position.y + 700, delta)


func attack():
	$AnimationPlayer.play("attack")


func hurt():
	if lives <= 0:
		is_following = false
		die()
	else:
		lives -= 1


func die():
	is_following = false
	is_dying = true
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
	elif anim_name == "Death":
		queue_free()


func _on_RandomTimer_timeout():
	if not is_dying:
		$AnimationPlayer.play("wind_up")
	
	
func _on_StartTimer_timeout():
	is_following = true
	$RandomTimer.random_start()
	BgmPlayer.resume()
