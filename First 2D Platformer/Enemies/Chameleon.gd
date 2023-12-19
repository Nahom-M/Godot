extends KinematicBody2D

export var START_POSITION = "IdleRight"#IdleLeft or IdleRight you choose

onready var animationPlayer = $AnimationPlayer
onready var particles = $Particles2D
onready var timer = $Timer

func _ready():
	animationPlayer.play(START_POSITION)

func _on_LeftPlayerDetectionZone_body_entered(_body):
	animationPlayer.play("AttackLeft")

func _on_LeftPlayerDetectionZone_body_exited(_body):
	particles.emitting = true
	animationPlayer.play("IdleRight")
	timer.start()

func _on_RightPlayerDetectionZone_body_entered(_body):
	animationPlayer.play("AttackRight")

func _on_RightPlayerDetectionZone_body_exited(_body):
	particles.emitting = true
	animationPlayer.play("IdleLeft")
	timer.start()

func _on_Timer_timeout():
	particles.emitting = false

func _on_Hurtbox_area_entered(_area):
	MusicController.play_no_damage()
