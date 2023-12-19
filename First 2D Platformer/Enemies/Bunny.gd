extends KinematicBody2D

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var timer = $JumpTimer

enum{ALIVE, DEAD}

var state = ALIVE
var velocity = Vector2.ZERO
var player_detected = false
var speed = -80
var jump = -200

func _physics_process(delta):
	if player_detected:
		velocity.x = speed
		animationPlayer.play("Run")
		timer.start()
	else:
		velocity = Vector2.ZERO
		animationPlayer.play("Idle")
	
	if is_on_floor() and player_detected:
		velocity.y = jump
	elif not is_on_floor() and player_detected:
		animationPlayer.play("Jump")
	
	velocity.y += 380 * delta
	sprite.flip_h = velocity.x > 0
	velocity = move_and_slide(velocity, Vector2.UP)

func alive(_delta):
	pass

func _on_PlayerDetectionZone_body_entered(_body):
	player_detected = true

func _on_Hurtbox_area_entered(_area):
	MusicController.play_enemy_death()
	animationPlayer.play("Death")
	set_physics_process(false)
	#state = DEAD
