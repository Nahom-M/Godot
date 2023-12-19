extends CanvasLayer

onready var fireballShots = $Display/FireballScore
onready var doubleJumpScore = $Display/DoubleJumpScore
onready var healthDisplay = $Display/Health

func _process(_delta):
	fireballShots.text = str(PlayerStats.FIREBALL_SHOTS)
	doubleJumpScore.text = str(PlayerStats.DOUBLE_JUMP)
	#healthDisplay.rect_size *= PlayerStats.HEALTH
