extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.get_action_strength("ui_accept"):
		get_tree().change_scene("res://Interface/MainMenu.tscn")
