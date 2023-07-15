extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

signal died

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

var isDead = false

func _ready():
	anim.play("idle")

func _physics_process(delta):
	if !isDead:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			get_node("JumpSound").play()
			anim.play("jump")

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction == -1:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
	
		if direction:
			velocity.x = direction * SPEED
			if velocity.y == 0:
				anim.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				anim.play("idle")
			
		if velocity.y > 0:
			anim.play("fall")
		
		move_and_slide()
	
		if Game.playerHP <= 0:
			death()
		
		if Game.playerGems >= 100:
			one_up()

func one_up():
	Game.playerGems = 0
	Game.playerLives += 1
	Utils.save_game()
	var tween = get_tree().create_tween()
	tween.tween_property(, "position", position - Vector2(0,30), 0.4)

func death():
	died.emit()
	get_node("AnimatedSprite2D").play("death")
	isDead = true
	get_node("DeathSound").play()
	get_node("DeathTimer").start()

func _on_death_timer_timeout():
	self.queue_free()
	Game.playerHP = 1
	Game.playerGems = 0
	Game.playerLives -= 1

	Utils.save_game()
	if Game.playerLives < 0:
		get_tree().change_scene_to_file("res://gameOverScreen.tscn")
	else:
		get_tree().change_scene_to_file("res://loadingScreen.tscn")
		

func _on_level_1_player_fall():
	death()

func _on_level_2_player_fall():
	death()
