extends Area2D

export (String) var track = ""
export (bool) var pause_area = false
var triggered = false

func _process(_delta):
	if not triggered:
		manage_collision()

func manage_collision():
	var collider = self.get_overlapping_bodies()
	for object in collider:
		if object.name == "Player":
			triggered = true
			if pause_area:
				BgmPlayer.pause()
			elif track == "":
				BgmPlayer.resume()
			elif track != "":
				BgmPlayer.playBGM(track)
			else:
				print("nothing is set")
