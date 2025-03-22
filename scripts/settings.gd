extends CanvasLayer

@onready var music_id = AudioServer.get_bus_index("Music")
@onready var sound_id = AudioServer.get_bus_index("Sound")

func _ready() -> void:
	$VBoxContainer/MusicSlider.value = Global.settings_data.music_volume
	$VBoxContainer/SoundSlider.value = Global.settings_data.sounds_volume
	$VBoxContainer/FullscreenCheck.button_pressed = Global.settings_data.fullscreen

func _on_back_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file(Global.menu_scene)


func _on_music_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(music_id, db)
	Global.update_music(value)


func _on_sound_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(sound_id, db)
	Global.update_sounds(value)


func _on_fullscreen_check_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED)
	Global.update_fullscreen(toggled_on)
