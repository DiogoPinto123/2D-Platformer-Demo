extends Node

var SAVE_PATH = "res://savegame.bin"

func clear_stats():
	Game.playerHP = 1
	Game.playerGems = 0
	Game.playerScore = 0
	Game.currentLevel = 1
	Game.playerLives = 1

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"playerGems": Game.playerGems,
		"playerScore": Game.playerScore,
		"currentLevel": Game.currentLevel,
		"playerLives": Game.playerLives,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerHP = current_line["playerHP"]
				Game.playerGems = current_line["playerGems"]
				Game.playerScore = current_line["playerScore"]
				Game.currentLevel = current_line["currentLevel"]
				Game.playerLives = current_line["playerLives"]
