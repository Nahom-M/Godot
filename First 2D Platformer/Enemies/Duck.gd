extends KinematicBody2D

export var START_ANIMATION = "Idle"

onready var animationPlayer = $AnimationPlayer
onready var jumpTimer = $JumpTimer
onready var particles = $Particles2D
onready var sprite = $Sprite

var player = null
var velocity = Vector2.ZERO
var jumpHeight = -50
var is_in_air = false
var timer_active = false
var gravity = 1000

func _ready():
	animationPlayer.play(START_ANIMATION)

func _physics_process(delta):
	if player != null:
		if player.position.x < position.x:
			sprite.flip_h = false
		elif player.position.x > position.x:
			sprite.flip_h = true
		
		if velocity.y == 0 and not timer_active:
			animationPlayer.play("JumpAnticipation")
			jumpTimer.start()
			timer_active = true
	else:
		velocity = Vector2.ZERO
		animationPlayer.play("Idle")
	
	if is_on_floor():
		is_in_air = false
	else:
		is_in_air = true
		timer_active = false
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_PlayerDetectionZone_body_entered(body):
	if body != self:
		player = body

func _on_PlayerDetectionZone_body_exited(_body):
	player = null

func _on_JumpTimer_timeout():
	position.y += jumpHeight
	animationPlayer.play("Jump")
	particles.emitting = true

func _on_Hurtbox_area_entered(_area):
	MusicController.play_no_damage()
