extends Node

@onready var audioPlayers = $AudioPlayers

const COIN_COLLECTED = preload("res://Sounds/CoinCollected.wav")

func play_sound(sound):
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break
