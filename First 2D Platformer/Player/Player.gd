extends KinematicBody2D
class_name Player

enum {MOVE, POWERUP}

onready var animatedSprite = $AnimatedSprite
onready var coyoteJumpTimer = $CoyoteJumpTimer
onready var cooldownTimer = $CooldownTimer
onready var powerupPositionRight = $Position2DRight
onready var powerupPositionLeft = $Position2DLeft

const FIREBALL = preload("res://Powerups/Fireball.tscn")

var velocity = Vector2.DOWN
var state = MOVE
var used_double_jump = false
var coyote_jump = false
#var buffered_jump = false

func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_axis('ui_left', 'ui_right')
	input.y = Input.get_axis("ui_up", 'ui_down')
	
	match state:
		MOVE: move_state(input, delta)
		POWERUP: powerup_state(input)
	
	var was_in_air = not is_on_floor()
	var was_on_floor = is_on_floor()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		animatedSprite.animation = 'Run'
		animatedSprite.frame = 1
	
	var just_left_ground = not is_on_floor() and was_on_floor
	if just_left_ground and velocity.y >= 0:
		coyote_jump = true
		coyoteJumpTimer.start()

func move_state(input, delta):
	apply_gravity(delta)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)
	
	horizontal_movement_input(delta, input)
	
	if not is_on_floor():
		animatedSprite.animation = 'Jump'
	
	if is_on_floor() or coyote_jump:#can_jump/input_jump
		apply_jump()
		
	else:
		apply_release_force()
		apply_fall_speed(delta)
		double_jump_check_and_apply()
	
	if Input.is_action_just_pressed("use_powerup") and PlayerStats.FIREBALL_SHOTS > 0 and cooldownTimer.time_left == 0:
		state = POWERUP

func apply_gravity(delta):
	velocity.y += PlayerStats.GRAVITY * delta #gravity
	velocity.y = min(velocity.y, 300)

func horizontal_movement_input(delta, input):
	if input.x == 0:
		velocity.x = move_toward(velocity.x, 0, PlayerStats.FRICTION * delta)#friction
		animatedSprite.animation = 'Idle'
	
	else:
		velocity.x = move_toward(velocity.x, PlayerStats.SPEED * input.x, PlayerStats.ACCELERATION * delta)#acceleration
		animatedSprite.animation = 'Run'
		animatedSprite.flip_h = input.x < 0

func apply_jump():
	used_double_jump = false
	if Input.is_action_just_pressed("ui_up"):
		MusicController.play_player_jump()
		velocity.y = PlayerStats.JUMP_HEIGHT

func apply_release_force():
	if Input.is_action_just_released("ui_up") and velocity.y < PlayerStats.JUMP_RELEASE_FORCE:#jump release
		velocity.y = PlayerStats.JUMP_RELEASE_FORCE

func apply_fall_speed(delta):
	if velocity.y > 0:#fall speed
		velocity.y += PlayerStats.FALL_SPEED * delta
		animatedSprite.animation = "Fall"

func double_jump_check_and_apply():
	if not is_on_floor() and PlayerStats.DOUBLE_JUMP > 0 and not used_double_jump and Input.is_action_just_pressed("ui_up"):
		used_double_jump = true
		PlayerStats.DOUBLE_JUMP -= 1
		MusicController.play_player_jump()
		velocity.y = PlayerStats.JUMP_HEIGHT

func powerup_state(_input):
	var fireball = FIREBALL.instance()
	get_parent().add_child(fireball)
	if animatedSprite.flip_h == false:
		fireball.position = powerupPositionRight.global_position
		fireball.set_fireball_direction(1)
		PlayerStats.FIREBALL_SHOTS -= 1
	elif animatedSprite.flip_h == true:
		fireball.position = powerupPositionLeft.global_position
		fireball.set_fireball_direction(-1)
		PlayerStats.FIREBALL_SHOTS -= 1
	cooldownTimer.start(1)
	#MusicController.play_fireball_sound()
	
	state = MOVE

func _on_Hurtbox_area_entered(_area):
	#if PlayerStats.HEALTH <= 0:
	MusicController.play_player_death()
		#PlayerStats.FIREBALL_SHOTS = 3
		#PlayerStats.DOUBLE_JUMP = 3
		#PlayerStats.HEALTH = 2
	get_tree().reload_current_scene()
	#else:
		#MusicController.play_enemy_hurt()
		#PlayerStats.HEALTH -= 1

func _on_CoyoteJumpTimer_timeout():
	coyote_jump = false
