extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

export var acceleration = 500#change in velocity over time
export var max_speed = 80
export var roll_speed = 1.5
export var friction = 500
#velocity, acceleration, friction all need to be multiplied by delta
enum {#enum enumerates and sets certain values
	MOVE,
	ROLL,
	ATTACK
}

var velocity = Vector2.ZERO#velocity is our position over time
var state = MOVE#state is for our new match state
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get('parameters/playback')
onready var sword_hitbox = $HitboxPivot/SwordSwingHitbox
onready var hurtbox = $Hurtbox
onready var blink_animation_player = $BlinkAnimationPlayer
onready var sprite = $Sprite

func _ready():#Keeps animation tree active
	randomize()
	stats.connect("no_health", self, "queue_free")
	animation_tree.active = true
	sword_hitbox.knockback_vector = roll_vector

func _physics_process(delta):#This is like a switch to play different functions depending on what we need
	match state:#match statements are similar to switch statements, example; if state matchs x/y/z then do this
		MOVE:
			move_state(delta)
		ROLL:
			roll_state()
		ATTACK:
			attack_state()

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		sword_hitbox.knockback_vector = input_vector
		animation_tree.set('parameters/Idle/blend_position', input_vector)
		animation_tree.set('parameters/Run/blend_position', input_vector)
		animation_tree.set('parameters/Attack/blend_position', input_vector)
		animation_tree.set('parameters/Roll/blend_position', input_vector)
		animation_state.travel('Run')
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	
	else:
		animation_state.travel('Idle')
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move()
	
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func roll_state():
	velocity = roll_vector * max_speed * roll_speed
	animation_state.travel('Roll')
	move()

func attack_state():
	velocity = Vector2.ZERO
	animation_state.travel('Attack')

func move():
	velocity = move_and_slide(velocity)

func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE

func attack_animation_finished():
	state = MOVE

func _on_Hurtbox_area_entered(_area):
	stats.health -= 1
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)

func _on_Hurtbox_invincibility_started():
	blink_animation_player.play("Start")
	#sprite.material.set_shader_param("flash_modifier", 1)

func _on_Hurtbox_invincibility_ended():
	blink_animation_player.play("Stop")
	#sprite.material.set_shader_param("flash_modifier", 0)
