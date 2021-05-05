extends KinematicBody2D

var motion = Vector2(0,0)
var numJump = MAX_JUMP

const SPEED = 75
const GRAVITY = 50
const UP = Vector2(0,-1)
const JUMP_SPEED = 1000
const MAX_JUMP = 3
const MAX_SPEED = SPEED * 5
const WORLD_LIMIT = 3000
const BOOST_MULTIPLIER = 3
var is_hurt = false
var snap
var max_vel = 0.0
var is_invincible = false

signal animate

func _ready():
	if Global.bonusLevelCompleted && Global.bonusEffects:
		$Particles2D.visible = true
		$PlayerAnimation.modulate = Color(1,.7,.5)

func _physics_process(_delta):
	apply_gravity()
	move()
	animate()
	snap = Vector2.DOWN * 16 if is_on_floor() else Vector2.ZERO
	jump()
# warning-ignore:return_value_discarded
	move_and_slide_with_snap(motion, snap, UP)


func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "die")
	if is_on_floor() and motion.y >= 0:
		motion.y = 0
		numJump = MAX_JUMP
		$JumpSFX.pitch_scale = 1
		max_vel = 0
		is_hurt = false
	else:
		motion.y += GRAVITY
		max_vel = max(max_vel, motion.y)
	if is_on_ceiling():
		snap = Vector2.ZERO
		motion.y = -motion.y


func jump():
	if Input.is_action_just_pressed("jump") && numJump > 0:
		if is_on_floor():
			motion.y = -JUMP_SPEED
			$JumpSFX.play()
		elif numJump > 0:
			motion.y = 0
			motion.y = -JUMP_SPEED
			$JumpSFX.pitch_scale -= .15
			$JumpSFX.play()
		numJump -= 1
		snap = Vector2.ZERO


func move():
	motion.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) * SPEED + motion.x * .9
	


func animate():
	emit_signal("animate", motion, SPEED, is_on_floor(), is_hurt)


func hurt():
	if not is_invincible:
		is_hurt = true
		motion.y = 0
		position.y -= 1
		yield(get_tree(), "idle_frame")
		motion.y = -JUMP_SPEED
		if motion.x != 0:
			motion.x = -MAX_SPEED*2*(motion.x/abs(motion.x))
		$PainSFX.play()
		is_invincible = true
		$InvincibilityTimer.start(0.5)


func boost():
# warning-ignore:unused_variable
	var currentVelocity = motion.y
	motion.y = 0
	position.y -= 1
	yield(get_tree(), "idle_frame")
	if abs(max_vel) > JUMP_SPEED*BOOST_MULTIPLIER:
		motion.y -= max_vel + GRAVITY * 2
	else:
		motion.y = -JUMP_SPEED*BOOST_MULTIPLIER


func _on_InvincibilityTimer_timeout():
	is_invincible = false
