extends Area2D

var velocity = Vector2.ZERO
export var SPEED = 200
var direction = 1
var fireball_expired = false

func _ready():
	pass

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	if not fireball_expired:
		$AnimationPlayer.play("Move")

func _on_DeleteSelfTimer_timeout():
	$AnimationPlayer.play("Explode")
	fireball_expired = true
