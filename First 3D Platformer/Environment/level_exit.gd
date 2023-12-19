extends StaticBody3D

@export var nextLevel : PackedScene

func _on_area_3d_body_entered(_body):
	get_tree().change_scene_to_packed(nextLevel)
