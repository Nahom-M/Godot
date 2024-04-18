extends CharacterBody2D

@onready var label = $label

var speed = 100.0
var direction = 1

func _physics_process(delta):
	if is_on_wall():
		direction *= -1
	
	velocity.x = direction * speed
	velocity.y = direction * speed

	move_and_slide()

func _on_area_2d_body_entered(_body):
	label.visible = true
	speed = 0

func _on_player_detection_body_exited(_body):
	label.visible = false
	speed = 100
