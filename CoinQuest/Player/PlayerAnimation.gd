extends AnimatedSprite

var was_hurt

func _on_Player_animate(motion, SPEED, is_on_floor, is_hurt):
	if not is_hurt:
		if motion.y < 0 && not is_on_floor:
			play("jump")
		elif motion.x >= SPEED:
			play("walk")
			flip_h = false
		elif motion.x <= -SPEED:
			play("walk")
			flip_h = true
		else:
			play("idle")
	else:
		play("hurt")

func _on_DummyPlayer_animate(motion, SPEED):
	if motion.y < 0:
		play("jump")
	elif motion.x >= SPEED:
		play("walk")
		flip_h = false
	elif motion.x <= -SPEED:
		play("walk")
		flip_h = true
	else:
		play("idle")

