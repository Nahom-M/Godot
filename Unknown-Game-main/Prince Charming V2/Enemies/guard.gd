extends CharacterBody2D

@onready var timer = $Timer

enum {
	IDLE,
	HORIZONTAL,
	VERTICAL,
	CHASING
}

var state = IDLE
var player = null
var value = 0
var rng = RandomNumberGenerator.new()
const SPEED = 125.0

func _physics_process(_delta):
	match state:
		IDLE:
			idle()
		HORIZONTAL:
			horizontal()
		VERTICAL:
			vertical()
		CHASING:
			chasing()

	move_and_slide()

func idle():
	velocity.y = 0
	velocity.x = 0

func horizontal():
	if value > 2:
		velocity.x = SPEED
	else:
		velocity.x = -1 * SPEED

func vertical():
	if value > 2:
		velocity.y = SPEED
	else:
		velocity.y = -1 * SPEED

func chasing():
	if player != null:
		#look_at(player.global_position)
		velocity.x = (player.global_position.x - global_position.x)
		velocity.y = (player.global_position.y - global_position.y)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

func _on_player_detection_body_entered(body):
	player = body

func _on_player_detection_body_exited(_body):
	player = null

func _on_timer_timeout():
	rng.randomize()
	value = rng.randi_range(1, 5)
	
	match value:
		1: state = IDLE
		2: state = VERTICAL
		3: state = HORIZONTAL
		4: state = CHASING
	
	timer.start()
