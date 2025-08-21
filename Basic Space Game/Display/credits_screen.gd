extends Control

@onready var main_menu = $MainMenu

func _ready():
	main_menu.grab_focus()

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Display/start_screen.tscn")
