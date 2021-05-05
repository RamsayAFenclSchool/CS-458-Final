extends Node2D


onready var player = get_parent().get_parent().get_parent()
var lives = 0
export var is_following = true
export var cutoff = 32500
var y_off
var x_off


func _ready():
	var num = rand_range(1.0, 4.0)
	y_off = rand_range(-700, 700)
	x_off = rand_range(-900, 200)
	$".".set_scale(Vector2(num, num))
	if is_following:
		$AnimationPlayer.play("Idle")
	else:
		pass


func _process(delta):
	if is_following:
		if player.player_location.x < cutoff:
			global_position.x = lerp(global_position.x, player.player_location.x+x_off, delta)
			if abs((global_position.x+x_off) - player.player_location.x) < 350:
				global_position.y = lerp(global_position.y, player.player_location.y, delta)
			else:
				global_position.y = lerp(global_position.y, player.player_location.y+y_off, delta)
	manage_collision()

func manage_collision():
	var collider = $AnimatedSprite/Area2D.get_overlapping_bodies()
	for object in collider:
		if object.name == "Player":
			get_tree().call_group("Gamestate", "hurt")
