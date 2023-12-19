extends Node2D

func _ready():
	MusicController.play_boss_theme()
	PlayerStats.FIREBALL_SHOTS = 30
	PlayerStats.DOUBLE_JUMP = 30

func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position

