extends RigidBody2D


export var delete_on_contact = true

var motion = Vector2(0,0)
const GRAVITY = 50
const UP = Vector2(0,-1)

var taken = false
var impact = 0

func _on_Area2D_body_entered(_body):
	if not delete_on_contact:
		if not taken:
			taken = true
			$AnimationPlayer.play("consumed")
			$AudioStreamPlayer2D.play()
			get_tree().call_group("Gamestate", "add_coin")

func die():
	queue_free()

func _on_dropperCoin_body_entered(_body):
	if delete_on_contact:
		impact += 1
		if impact > 3:
			taken = true
			$AnimationPlayer.play("consumed")
