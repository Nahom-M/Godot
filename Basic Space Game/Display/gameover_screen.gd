extends Control

@onready var score = $Score
@onready var retry = $Retry
@onready var gameover_sound = $AudioStreamPlayer2D
@onready var select_sound = $AudioStreamPlayer2DSelect
@onready var mute_button = $MuteButton

const mute_icon = preload("res://Assets/mute.png")
const unmute_icon = preload("res://Assets/unmute.png")

func _ready():
	gameover_sound.play()
	score.text = str(Stats.ENDLESS_MODE_SCORE)
	retry.grab_focus()
	mute_button.texture_normal = unmute_icon if !Stats.IS_MUTED else mute_icon

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Levels/endless.tscn")

func _on_retry_focus_entered() -> void:
	select_sound.play()

func _on_mute_button_pressed() -> void:
	Stats.IS_MUTED = !Stats.IS_MUTED
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), Stats.IS_MUTED)

	if Stats.IS_MUTED:
		mute_button.texture_normal = mute_icon
	else:
		mute_button.texture_normal = unmute_icon
