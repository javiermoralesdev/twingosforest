extends Node

var paused = false
var high_score = 0

var game_scene = "res://scenes/game.tscn"

func process_high_score(score: int):
	if score > high_score:
		high_score = score
