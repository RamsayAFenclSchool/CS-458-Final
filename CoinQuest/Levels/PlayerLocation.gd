extends Node2D

var camera_follow = true
var player_location = Vector2.ZERO

func _process(_delta):
	if camera_follow == true:
		player_location = $Player.global_position
		$Camera2D2.global_position = player_location
	else:
		pass
