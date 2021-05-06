extends KinematicBody2D


var motion = Vector2(0,0)
const SPEED = 50
const GRAVITY = 50
const UP = Vector2(0,-1)
const MAX_SPEED = SPEED * 5
var direction = 1

func _physics_process(_delta):
	if is_on_wall():
		motion.x = 0
		if $roomba.flip_h == false:
			$roomba.flip_h = true
		else:
			$roomba.flip_h = false
		direction *= -1.0
	apply_gravity()
	move()
# warning-ignore:return_value_discarded
	move_and_slide(motion, UP)

func apply_gravity():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY

func move():
	if motion.x*direction < MAX_SPEED*direction:
# warning-ignore:integer_division
		motion.x += (SPEED/2)*direction
	else :
		motion.x = MAX_SPEED*direction



func _on_Area2D_body_entered(_body):
	get_tree().call_group("Gamestate", "hurt")
