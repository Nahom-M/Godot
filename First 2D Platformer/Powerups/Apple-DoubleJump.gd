extends Area2D

func _ready():
	$AnimationPlayer.play("Idle")

func _on_AppleDoubleJump_body_entered(_body):
	PlayerStats.DOUBLE_JUMP += 1
	$AnimationPlayer.play("Collected")
	MusicController.play_powerup_collected()
