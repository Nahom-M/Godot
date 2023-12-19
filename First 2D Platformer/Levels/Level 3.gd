extends Node2D

func _ready():
	MusicController.play_background_music()
	PlayerStats.FIREBALL_SHOTS = 3
	PlayerStats.DOUBLE_JUMP = 3

func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position
