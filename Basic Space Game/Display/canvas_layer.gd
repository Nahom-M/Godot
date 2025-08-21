extends CanvasLayer

@onready var texture_rect = $TextureRect
@onready var score = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	texture_rect.size.x = 48 * Stats.PLAYER_HEALTH
	score.text = str(Stats.ENDLESS_MODE_SCORE)
