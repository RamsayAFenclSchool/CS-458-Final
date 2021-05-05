extends KinematicBody2D

var motion = Vector2(0,0)
const SPEED = 50
const JUMP_SPEED = 1000
const GRAVITY = 50
const UP = Vector2(0,-1)
const MAX_SPEED = SPEED * 5
var direction = 1

export (bool) var enable_movement = true
export (bool) var enable_tog = false

var tog = enable_tog

export var min_wait_time = 0.5
export var max_wait_time = 2.0
export var loops = true
export var auto = true
export var sound = true

signal animate

func _ready():
	BgmPlayer.resume()
	if Global.bonusLevelCompleted && Global.bonusEffects:
		$Particles2D.visible = true
		$PlayerAnimation.modulate = Color(1,.7,.5)

func _physics_process(_delta):
	if is_on_wall():
		motion.x = 0
		direction *= -1.0
	apply_gravity()
	animate()
	move()
	jump()
	$ParallaxBackground.scroll_offset = Vector2(-global_position.x*.2, 447)
# warning-ignore:return_value_discarded
	move_and_slide(motion, UP)

func apply_gravity():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY

func animate():
	emit_signal("animate", motion, SPEED)

func move():
	if enable_movement:
		if motion.x*direction < MAX_SPEED*direction:
# warning-ignore:integer_division
			motion.x += (SPEED/2)*direction
		else :
			motion.x = MAX_SPEED*direction

func jump():
	if tog:
		if is_on_floor():
			motion.y = -JUMP_SPEED
			if sound:
				SfxPlayer.playSFX("res://SFX/jump1.ogg")

func fake_input_press():
	var fake_jump = InputEventAction.new()
	fake_jump.action = "jump"
	fake_jump.pressed = true
	Input.parse_input_event(fake_jump)


# warning-ignore:unused_argument
func _on_EffectVol_value_changed(value):
	tog = true
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	tog = false


func _on_EffectButton_toggled(button_pressed):
	if Global.bonusLevelCompleted:
		if button_pressed:
			Global.bonusEffects = true
			$Particles2D.visible = true
			$PlayerAnimation.modulate = Color(1,.7,.5)
		else:
			Global.bonusEffects = false
			$Particles2D.visible = false
			$PlayerAnimation.modulate = Color(1,1,1)


func _on_RandomTimer_timeout():
	tog = true
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	tog = false
