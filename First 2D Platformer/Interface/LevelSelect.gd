extends Control

onready var start_btn = $Levels1to5/HBoxContainer/level1

func _ready():
	start_btn.grab_focus()

func _process(_delta):
	if Input.get_action_strength("ui_cancel"):
		get_tree().change_scene("res://Interface/Menu.tscn")

func _on_level1_pressed():
	get_tree().change_scene("res://Levels/Level 1.tscn")

func _on_level2_pressed():
	get_tree().change_scene("res://Levels/Level 2.tscn")

func _on_level3_pressed():
	get_tree().change_scene("res://Levels/Level 3.tscn")

func _on_level4_pressed():
	get_tree().change_scene("res://Levels/Level 4.tscn")

func _on_level5_pressed():
	get_tree().change_scene("res://Levels/Level 5.tscn")

func _on_level6_pressed():
	get_tree().change_scene("res://Levels/Level 6.tscn")

func _on_level7_pressed():
	get_tree().change_scene("res://Levels/Level 7.tscn")

func _on_level8_pressed():
	get_tree().change_scene("res://Levels/Level 8.tscn")

func _on_level9_pressed():
	get_tree().change_scene("res://Levels/Level 9.tscn")

func _on_level10_pressed():
	get_tree().change_scene("res://Levels/Level 10.tscn")
