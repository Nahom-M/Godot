extends Node

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		self.visible = false
		get_tree().paused = false
	
	if Input.is_action_just_pressed("trade"):
		self.visible = true
		get_tree().paused = true
