extends Sprite

const grass_effect = preload("res://Effects/GrassEffect.tscn")

func create_grass_effect():
	var GrassEffect = grass_effect.instance()
	get_parent().add_child(GrassEffect)
	GrassEffect.global_position = global_position
	queue_free()

func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
