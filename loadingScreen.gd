extends CanvasLayer

var currentLevel = str(Game.currentLevel)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("LoadingSound").play()
	get_node("LevelPreview").texture = load("res://Level Previews/level"+currentLevel+"_preview.png")
	get_node("Timer").start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://level"+str(Game.currentLevel)+".tscn")
