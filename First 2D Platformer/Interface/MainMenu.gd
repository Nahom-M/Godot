extends Control

onready var settings = $Settings
onready var help = $Explanation
onready var start_btn = $BottomRect/VBoxContainer/Start

func _ready():
	MusicController.play_title_screen()
	start_btn.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene("res://Interface/LevelSelect.tscn")

func _on_Settings_pressed():
	settings.popup()

func _on_Help_pressed():
	help.popup()

func _on_Exit_pressed():
	get_tree().quit()

