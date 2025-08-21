extends Area2D

var meteor = preload("res://Enemies/meteor.tscn")
var speed = 300

func _ready():
	randomize()
	position.x = randi_range(0, 1130)

func _process(delta):
	position.y += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	var instance = meteor.instantiate()
	add_child(instance)
