extends KinematicBody2D

export var START_ANIMATION = "Idle"

onready var animationPlayer = $AnimationPlayer
onready var timer = $SprintTimer
onready var particles = $Particles2D

enum {ALIVE, HURT, DEAD}

var state = ALIVE
var player = null
var velocity = Vector2.ZERO
var right_speed = 50
var left_speed = -50
var gravity = 4600
var health = 3

func _ready():
	animationPlayer.play(START_ANIMATION)

func _physics_process(delta):
	match state:
		ALIVE:
			alive(delta)
		HURT:
			hurt()
		DEAD:
			damaged()

func alive(delta):
	if player != null:
		if player.position.x < position.x:
			velocity = player.position.direction_to(position) * left_speed
			animationPlayer.play("RunLeft")
		elif player.position.x > position.x:
			velocity = position.direction_to(player.position) * right_speed
			animationPlayer.play("RunRight")
		else:
			velocity = Vector2.ZERO
			animationPlayer.play("Idle")
			
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.DOWN)

func hurt():
	animationPlayer.play("Hit")

func damaged():
	animationPlayer.play("Death")

func switch_state():
	state = ALIVE

func _on_PlayerDetectionZone_body_entered(body):
	if body != self:
		player = body
	timer.start()

func _on_PlayerDetectionZone_body_exited(_body):
	player = null
	right_speed = 50
	left_speed = -50

func _on_SprintTimer_timeout():
	right_speed *= 3
	left_speed *= 3
	particles.emitting = true

func _on_Hurtbox_area_entered(_area):
	health -= 1
	if health > 0:
		MusicController.play_enemy_hurt()
		state = hurt()
	if health <= 0:
		MusicController.play_enemy_death()
		state = damaged()
