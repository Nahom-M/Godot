extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer

var player = null
var velocity = Vector2.ZERO
var speed = 40
var gravity = 3000
var on_ground = true
var fall_state = false
var health = 10

func _ready():
	animationPlayer.play("Ground")

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if player != null:
		animationPlayer.play("Idle")
		velocity = position.direction_to(player.position) * speed
	else:
		velocity.y += gravity * delta
		if is_on_wall() and on_ground:
			animationPlayer.play("Ground")
			on_ground = false
	
	#print(on_ground)
	#print(is_on_wall())
	velocity = move_and_slide(velocity)

func _physics_process_check():
	set_physics_process(true)

func _on_PlayerDetectionZone_body_entered(body):
	if body != self:
		player = body
	on_ground = false
	fall_state = true

func _on_PlayerDetectionZone_body_exited(_body):
	player = null
	on_ground = true
	if fall_state:
		animationPlayer.play("Fall")
		fall_state = false

func _on_Hurtbox_area_entered(_area):
	health -= 1
	animationPlayer.play("Hit")
	set_physics_process(false)
	MusicController.play_enemy_hurt()
	if health <= 0:
		MusicController.play_enemy_death()
		animationPlayer.play("Death")
		set_physics_process(false)
