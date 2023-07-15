extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MainMenuMusic").play()
	Utils.load_game()
	
	if Game.currentLevel == 1:
		get_node("Continue").set_deferred("disabled", true)
	else:
		get_node("Continue").set_deferred("disabled", false)

func _on_quit_pressed():
	get_tree().quit()

func _on_new_game_pressed():
	Utils.clear_stats()
	Utils.save_game()
	get_tree().change_scene_to_file("res://loadingScreen.tscn")

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://loadingScreen.tscn")
