extends Node2D

@onready var meteor_timer = $MeteorTimer

var meteor_counter = 0

var meteor = preload("res://Enemies/meteor.tscn")

func _ready():
	Stats.ENDLESS_MODE_SCORE = 0

func _process(_delta):
	if meteor_counter >= 5 and meteor_counter < 20:#since I used 5 the 0-4 will be at 0.075
		meteor_timer.wait_time = 0.5
	elif meteor_counter >= 20 and meteor_counter < 100:
		meteor_timer.wait_time = 0.1
	else:
		meteor_timer.wait_time = 0.075

func _on_timer_timeout():
	var instance = meteor.instantiate()
	add_child(instance)
	meteor_counter += 1
	Stats.ENDLESS_MODE_SCORE += 1
