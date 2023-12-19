extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var starting_position = global_position

const  SPEED = 200.0
const JUMP_VELOCITY = -325.0
const ACCELERATION = 800
const FRICTION = 800

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var input = Input.get_axis("left", "right")

	apply_gravity(delta)
	handle_jump()
	handle_wall_jump()
	handle_movement(input)
	apply_acceleration(input, delta)
	apply_friction(input, delta)
	update_animation()
	var was_on_floor = is_on_floor()
	move_and_slide()
	var left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if left_ledge:
		coyote_jump_timer.start()

func handle_movement(input):
	if input:
		velocity.x = input * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_wall_jump():
	if not is_on_wall():#checks if its already doing a wall jump
		return
	var wall_normal = get_wall_normal()#checks wall collision
	if Input.is_action_just_pressed("left") and wall_normal == Vector2.LEFT:
		velocity.x = wall_normal.x * SPEED
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("right") and wall_normal == Vector2.RIGHT:
		velocity.x = wall_normal.x * SPEED
		velocity.y = JUMP_VELOCITY

func handle_jump():
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("up"):
			velocity.y = JUMP_VELOCITY

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func apply_friction(input, delta):
	if input == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func apply_acceleration(input, delta):
	if input != 0:
		velocity.x = move_toward(velocity.x, SPEED * input, ACCELERATION * delta)

func update_animation():
	if velocity.x != 0:
		animated_sprite_2d.flip_h = velocity.x < 0
		animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Idle")
	
	if not is_on_floor():
		animated_sprite_2d.play("Jump")

func _on_hazard_detector_area_entered(area):
	global_position = starting_position
