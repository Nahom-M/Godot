extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

var player = null
var velocity = Vector2.ZERO
var speed = 85
var gravity = 18000
var health = 4

func _ready():
	animationPlayer.play("Idle")

func _physics_process(delta):
	
	if player != null:
		animationPlayer.play("Run")
		velocity = position.direction_to(player.position) * speed
		sprite.flip_h = position.x < player.position.x
	else:
		velocity = Vector2.ZERO
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.DOWN)

func _physics_process_true():
	set_physics_process(true)

func _on_PlayerDetectionZone_body_entered(body):
	if body != self:
		player = body

func _on_Hurtbox_area_entered(_area):
	health -= 1
	set_physics_process(false)
	if health > 0:
		MusicController.play_enemy_hurt()
		animationPlayer.play("Hit")
	else:
		MusicController.play_enemy_death()
		animationPlayer.play("Death")
