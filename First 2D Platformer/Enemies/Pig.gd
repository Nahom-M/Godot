extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var leftLedgeCheck = $LeftCheck
onready var rightLedgeCheck = $RightCheck
onready var sprite =  $AnimatedSprite
onready var deathTimer = $DeathTimer

func _physics_process(_delta):
	var found_wall = is_on_wall()
	var found_ledge = not leftLedgeCheck.is_colliding() or not rightLedgeCheck.is_colliding()
	
	if found_wall or found_ledge:
		direction *= -1
	
	sprite.flip_h = direction.x > 0
	
	velocity = direction * 35
	move_and_slide(velocity, Vector2.UP)

func _on_Hurtbox_area_entered(_area):
	set_physics_process(false)
	sprite.play("Death")
	MusicController.play_enemy_death()
	deathTimer.start()

func _on_DeathTimer_timeout():
	queue_free()
