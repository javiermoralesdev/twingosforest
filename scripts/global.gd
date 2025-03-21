extends Node

var paused = false
var high_score = 0

var game_scene = "res://scenes/game.tscn"
var menu_scene = "res://scenes/main_menu.tscn"
var tutorial_scene = "res://scenes/tutorial.tscn"
var intro_scene = "res://scenes/intro.tscn"
var credits_scene = "res://scenes/credits.tscn"
var settings_scene = "res://scenes/settings.tscn"

func process_high_score(score: int):
	if score > high_score:
		high_score = score
