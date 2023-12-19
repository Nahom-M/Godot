extends PopupMenu

onready var creditsPopup = $CreditsPopup

var master_bus = AudioServer.get_bus_index("BGM")
var sound_bus = AudioServer.get_bus_index("SFX")

func _ready():
	pass
	#start_btn.grab_focus()

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)



func _on_SfxSlider_value_changed(value):
	AudioServer.set_bus_volume_db(sound_bus, true)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)

func _on_Credits_pressed():
	creditsPopup.popup()
