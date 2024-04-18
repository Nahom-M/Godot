extends CharacterBody2D

var merchant_found = false
const SPEED = 300.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	if direction_x or direction_y:
		velocity.x = direction_x * SPEED
		velocity.y = direction_y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	

	move_and_slide()

func _on_merchant_finder_body_entered(_body):
	merchant_found = true

func _on_merchant_finder_body_exited(_body):
	merchant_found = false
