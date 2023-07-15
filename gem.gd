extends Area2D

func _ready():
	get_node("AnimatedSprite2D").play("default")


func _on_body_entered(body):
	if body.name == "Player":
		get_node("GemPickupSound").play()
		get_node("CollisionShape2D").set_deferred("disabled",true)
		Game.playerGems += 1
		Game.playerScore += 100
		Utils.save_game()
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0,30), 0.4)
		tween1.tween_property(self, "modulate:a", 0, 0.4)
		tween.tween_callback(queue_free)
