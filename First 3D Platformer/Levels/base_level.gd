extends Node3D

@onready var pause_menu = $PauseMenu

func _process(_delta):
	if Input.is_action_just_pressed("cancel"):
		pause_menu.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		
