extends Node

export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health

signal heath_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("heath_changed", health)

func _ready():
	self.health = max_health
