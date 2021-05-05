extends Timer

export var min_wait_time = 0.5
export var max_wait_time = 2.0
export var loops = true
export var auto = true
export var take_from_parent = true

onready var parent = get_parent()

func _ready():
	if parent != null && take_from_parent:
		min_wait_time = parent.min_wait_time
		max_wait_time = parent.max_wait_time
		loops = parent.loops
		auto = parent.auto
	autostart = auto
	one_shot = !loops
	if autostart:
		random_start()

func random_start(time = rand_range(min_wait_time, max_wait_time)):
	start(time)

func _on_RandomTimer_timeout()-> void:
	if not one_shot:
		random_start()
