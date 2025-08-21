extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var hurt_sound = $AudioStreamPlayer2D

const SPEED = 300.0

func _physics_process(_delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	if direction_x or direction_y:
		velocity.x = direction_x * SPEED
		velocity.y = direction_y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _on_hurtbox_area_entered(_area):
	animation_player.play("hurt")
	hurt_sound.play()
	Stats.PLAYER_HEALTH -= 1
	if Stats.PLAYER_HEALTH == 0:
		queue_free()
		Stats.PLAYER_HEALTH = 4
		get_tree().change_scene_to_file("res://Display/gameover_screen.tscn")
