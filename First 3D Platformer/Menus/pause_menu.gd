extends Control

@onready var continue_btn = $VBoxContainer/Continue

func _on_continue_pressed():
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func _on_quit_pressed():
	get_tree().quit()
