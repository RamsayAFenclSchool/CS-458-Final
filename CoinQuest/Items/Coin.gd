extends Node2D

var taken = false

func _on_Area2D_body_entered(_body):
	if not taken:
		taken = true
		$AnimationPlayer.play("consumed")
		$AudioStreamPlayer2D.play()
		get_tree().call_group("Gamestate", "add_coin")

func die():
	queue_free()
