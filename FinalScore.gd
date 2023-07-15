extends Label

func _process(delta):
	text = "Final score: " + str(Game.playerScore)
