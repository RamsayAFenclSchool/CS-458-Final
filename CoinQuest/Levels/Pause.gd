extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not.get_tree().paused
		get_tree().paused = new_pause_state
		get_tree().call_group("GUI","GUI_show", new_pause_state)
		visible = new_pause_state
		if new_pause_state == true:
			BgmPlayer.pause()
		else:
			BgmPlayer.resume()

func _on_Continue_pressed():
	if get_tree().paused == true:
		var ev = InputEventAction.new()
		ev.action = "pause"
		ev.pressed = true
		Input.parse_input_event(ev)

