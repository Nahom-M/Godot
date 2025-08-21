extends Control

@onready var start = $Start
@onready var select_sound = $AudioStreamPlayer2D
@onready var mute_button = $MuteButton

const mute_icon = preload("res://Assets/mute.png")
const unmute_icon = preload("res://Assets/unmute.png")

func _ready():
	start.grab_focus()
	mute_button.texture_normal = unmute_icon if !Stats.IS_MUTED else mute_icon

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Levels/endless.tscn")

func _on_start_focus_entered() -> void:
	select_sound.play()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Display/credits_screen.tscn")

func _on_credits_focus_entered() -> void:
	select_sound.play()

func _on_mute_button_pressed() -> void:
	Stats.IS_MUTED = !Stats.IS_MUTED
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), Stats.IS_MUTED)

	if Stats.IS_MUTED:
		mute_button.texture_normal = mute_icon
	else:
		mute_button.texture_normal = unmute_icon
