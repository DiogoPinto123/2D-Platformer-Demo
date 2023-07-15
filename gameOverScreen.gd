extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("GameOverSound").play()
	get_node("GameOverTimer").start()
	get_node("HurtFox").play("hurt_fox")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://main.tscn")
	Game.playerLives = 1
	Game.playerScore = 0
	Game.currentLevel = 1
	Utils.save_game()
