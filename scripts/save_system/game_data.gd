extends Resource

class_name GameData

const GAME_DATA_PATH = "user://save.tres"

@export var high_score: int = 0

func save():
	ResourceSaver.save(self, GAME_DATA_PATH)

static func load() -> Resource:
	if ResourceLoader.exists(GAME_DATA_PATH):
		return load(GAME_DATA_PATH)
	return GameData.new()
