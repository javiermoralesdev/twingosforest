extends Resource

class_name SettingsData

const SETTINGS_DATA_PATH = "user://settings.tres"

@export var music_volume: float = 1.0
@export var sounds_volume: float = 1.0
@export var fullscreen: bool = false

func save():
	ResourceSaver.save(self, SETTINGS_DATA_PATH)

static func load():
	if ResourceLoader.exists(SETTINGS_DATA_PATH):
		return load(SETTINGS_DATA_PATH)
	return SettingsData.new()
