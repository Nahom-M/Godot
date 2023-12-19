extends PathFollow3D

func _process(delta):
	self.progress += 5 * delta
