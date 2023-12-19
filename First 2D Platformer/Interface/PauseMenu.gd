extends Control

onready var settings = $Settings
onready var resume_btn = $BottomRect/Resume

var is_paused = false setget set_is_paused
var settings_paused = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		self.is_paused = !is_paused
		resume_btn.grab_focus()

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_Resume_pressed():
	self.is_paused = false

func _on_Settings_pressed():
	settings.popup()

func _on_MainMenu_pressed():
	self.is_paused = false
	get_tree().change_scene("res://Interface/MainMenu.tscn")

