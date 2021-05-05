extends CanvasLayer

	
func update_GUI(lives_left, coins):
	$Control/TextureRect/HBoxContainer/LiveCount.text = "x" + str(lives_left)
	$Control/TextureRect/HBoxContainer/CoinCount.text = "x" + str(coins)

func GUI_show(state):
	$Control.visible = !state
