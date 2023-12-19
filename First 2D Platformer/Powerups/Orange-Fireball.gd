extends Area2D

func _ready():
	$AnimationPlayer.play("Idle")

func _on_OrangeFireball_body_entered(_body):
	PlayerStats.FIREBALL_SHOTS += 1
	$AnimationPlayer.play("Collected")
	MusicController.play_powerup_collected()
