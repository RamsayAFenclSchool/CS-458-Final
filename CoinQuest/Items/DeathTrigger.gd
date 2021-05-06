extends Area2D

export (String) var node = ""
var triggered = false

func _process(_delta):
	if not triggered:
		manage_collision()

func manage_collision():
	var collider = self.get_overlapping_bodies()
	for object in collider:
		if object.name == "Player":
			triggered = true
			if node == "":
				pass
			else:
				get_node(node).die()
