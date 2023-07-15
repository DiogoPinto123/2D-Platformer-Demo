extends Node2D
signal player_fall

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Level1Music").play()


func _on_end_of_level_body_entered(body):
	if body.name == "Player":
		Game.currentLevel += 1
		Utils.save_game()
		get_tree().change_scene_to_file("res://loadingScreen.tscn")
		
func _on_fall_area_level_1_body_entered(body):
	if body.name == "Player":
		player_fall.emit()
		
func _on_player_died():
	get_node("Level1Music").stop()
