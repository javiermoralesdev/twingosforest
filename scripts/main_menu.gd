extends CanvasLayer

func _ready() -> void:
	$ScoreLabel.text = tr("mm_hscore").format({"hscore": Global.high_score})


func go_to_level(level_name: String):
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file(level_name)

func _on_quit_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().quit()


func _on_tutorial_button_pressed() -> void:
	go_to_level(Global.tutorial_scene)


func _on_play_button_pressed() -> void:
	go_to_level(Global.intro_scene)


func _on_settings_button_pressed() -> void:
	go_to_level(Global.settings_scene)


func _on_credits_button_pressed() -> void:
	go_to_level(Global.credits_scene)
