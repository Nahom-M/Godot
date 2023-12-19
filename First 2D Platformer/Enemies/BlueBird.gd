extends KinematicBody2D

onready var sprite = $AnimatedSprite

var player = null
var velocity = Vector2.ZERO
var speed = 40
var acceleration = 100
var wander_speed = 45
var wander_limit = 0
var change_direction = -1

func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if player != null:
		velocity = position.direction_to(player.position) * speed
		wander_limit = 0
	else:
		velocity.x = wander_speed
		
		if wander_speed > 0:
			wander_limit += 1
		elif wander_speed < 0:
			wander_limit -= 1
		
		if wander_limit > 200 or wander_limit < -200 :
			wander_limit = 0
			wander_speed = wander_speed * change_direction
	
	sprite.flip_h = velocity.x > 0
	velocity = move_and_slide(velocity)

func _on_PlayerDetectionZone_body_entered(body):
	if body != self:
		player = body

func _on_PlayerDetectionZone_body_exited(_body):
	wander_speed = speed * change_direction
	player = null

func _on_Hurtbox_area_entered(_area):
	MusicController.play_enemy_death()
	sprite.play("Death")
	set_physics_process(false)
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	queue_free()
