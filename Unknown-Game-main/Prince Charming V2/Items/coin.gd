extends Area2D

func _on_body_entered(_body):
	PlayerStats.COINS += 1
	SoundPlayer.play_sound(SoundPlayer.COIN_COLLECTED)
	queue_free()
