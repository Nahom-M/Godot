extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_again_pressed():
	
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")

func _on_quit_pressed():
	get_tree().quit()
