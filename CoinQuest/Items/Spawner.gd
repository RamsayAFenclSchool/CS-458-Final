extends Position2D

signal spawned(spawn)

export (PackedScene) var spawnling_scene
export var is_active = true

export var top_level = true
export var min_wait_time = 0.5
export var max_wait_time = 2.0
export var loops = true
export var auto = true
export var collision_mask = 0

func spawn():
	if is_active:
		var spawnling = spawnling_scene.instance()
		add_child(spawnling)
		spawnling.set_as_toplevel(top_level)
		spawnling.global_position = global_position
		if collision_mask > 0:
			spawnling.set_collision_mask(collision_mask)
		emit_signal("spawned", spawnling)
		return spawnling

func _on_RandomTimer_timeout():
	if is_active:
		spawn()
