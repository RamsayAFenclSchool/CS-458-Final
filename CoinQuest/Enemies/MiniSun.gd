extends Node2D


onready var player = get_parent().get_parent().get_parent()
var lives = 0
export var is_following = true
var chase = false
var vector = Vector2.ZERO


func _ready():
	get_parent().remove_child(self)
	player.add_child(self)
	if is_following:
		$AnimationPlayer.play("Idle")
	else:
		pass

func _process(delta):
	if not chase && is_following:
		var before = global_position
		global_position = lerp(global_position, player.player_location, delta/2)
		var after = global_position
		vector = (after - before).normalized()
	elif chase && is_following:
		global_position += vector * 20
	manage_collision()

func attack():
	print("rawr")
	chase = true
	$AnimationPlayer.play("attack")

func manage_collision():
	var collider = $AnimatedSprite/Area2D.get_overlapping_bodies()
	for object in collider:
		if object.name == "Player":
			get_tree().call_group("Gamestate", "hurt")
		explode()

func explode():
	is_following = false
	$AnimationPlayer.play("explode")

func hurt():
	if lives <= 0:
		is_following = false
		die()
	else:
		lives -= 1

func die():
	$AnimationPlayer.play("Death")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "wind_up":
		attack()
		$DeathTimer.start()
	elif anim_name == "explode":
		queue_free()

func _on_StartTimer_timeout():
	$AnimationPlayer.play("wind_up")

func _on_DeathTimer_timeout():
	explode()
