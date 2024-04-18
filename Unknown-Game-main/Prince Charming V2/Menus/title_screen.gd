extends Control

@onready var start_game = $MarginContainer/HBoxContainer/VBoxContainer2/StartGame

func _ready():
	start_game.grab_focus()

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_game_pressed():
	get_tree().quit()
