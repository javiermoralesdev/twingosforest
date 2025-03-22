extends Node

var paused = false

var game_scene = "res://scenes/game.tscn"
var menu_scene = "res://scenes/main_menu.tscn"
var tutorial_scene = "res://scenes/tutorial.tscn"
var intro_scene = "res://scenes/intro.tscn"
var credits_scene = "res://scenes/credits.tscn"
var settings_scene = "res://scenes/settings.tscn"

@onready var game_data = GameData.load()
@onready var settings_data = SettingsData.load()

var first_run = false

func _ready() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(settings_data.music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear_to_db(settings_data.sounds_volume))
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if settings_data.fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)

func process_high_score(score: int):
	if score > game_data.high_score:
		game_data.high_score = score
		game_data.save()

func update_music(new_val: float):
	settings_data.music_volume = new_val
	settings_data.save()

func update_sounds(new_val: float):
	settings_data.sounds_volume = new_val
	settings_data.save()

func update_fullscreen(new_val: bool):
	settings_data.fullscreen = new_val
	settings_data.save()

func get_high_score() -> int:
	return game_data.high_score
