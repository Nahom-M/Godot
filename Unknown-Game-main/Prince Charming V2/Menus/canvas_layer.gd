extends CanvasLayer

@onready var coin_label = $CoinLabel

func _process(_delta):
	coin_label.text = "Coins: " + str(PlayerStats.COINS)
