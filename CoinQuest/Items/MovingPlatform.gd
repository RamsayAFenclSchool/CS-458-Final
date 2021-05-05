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
		direction *= -1.0
	move()
# warning-ignore:return_value_discarded
	move_and_slide(motion, UP)

func move():
	if motion.x*direction < MAX_SPEED*direction:
# warning-ignore:integer_division
		motion.x += (SPEED/2)*direction
	else :
		motion.x = MAX_SPEED*direction
