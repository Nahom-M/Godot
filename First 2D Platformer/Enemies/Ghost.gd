extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite

var velocity = Vector2.ZERO
var player = null
var speed = 40
var last_player_position = 0

func _ready():
	animatedSprite.play("Idle")

func _physics_process(_delta):
	if player != null:
		if player.position.x < position.x:
			velocity = player.position.direction_to(position) * (speed * -1)
			animatedSprite.flip_h = false
		elif player.position.x > position.x:
			velocity = position.direction_to(player.position) * speed
			animatedSprite.flip_h = true
	else:
		velocity = Vector2.ZERO
	
	velocity = move_and_slide(velocity)

func _on_PlayerDetectionZone_body_entered(body):
	if body != self:
		player = body

func _on_PlayerDetectionZone_body_exited(_body):
	player = null

func _on_Hurtbox_area_entered(_area):
	MusicController.play_no_damage()
