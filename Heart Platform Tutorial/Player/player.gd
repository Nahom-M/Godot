extends CharacterBody2D


@export var movement_data : PlayerMovementData

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * movement_data.gravity_scale

	# Handle Jump.
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("up"):
			velocity.y = movement_data.jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		#with move toward we wont instantly go at max speed and will natural go fast
		velocity.x = move_toward(velocity.x, movement_data.friction * direction, movement_data.acceleration * delta)
		#velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)

	update_animations()
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()

func update_animations():
	if velocity.x != 0:
		animated_sprite_2d.flip_h = velocity.x < 0
		animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Idle")
	
	if not is_on_floor():
		animated_sprite_2d.play("Jump")
