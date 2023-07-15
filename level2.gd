extends Node2D
signal player_fall

func _ready():
	get_node("CaveMusic").play()

func _on_fall_area_level_2_body_entered(body):
	if body.name == "Player":
		player_fall.emit()

func _on_player_died():
	get_node("CaveMusic").stop()
