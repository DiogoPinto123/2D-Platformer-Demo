extends Label

func _process(delta):
	text = "Level " + str(Game.currentLevel)
