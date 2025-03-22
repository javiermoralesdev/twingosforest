extends ColorRect

func appear():
	visible = true
	Global.process_high_score(%Player.score)
	$GameOverAnim.play("show")
	$ScoreText.text = tr("score").format({"score": %Player.score})
	%ScoreLabel.visible = false
	%PauseButton.visible = false
	%MusicPlayer.stop()
	$HighscoreText.text = tr("mm_hscore").format({"hscore": Global.get_high_score()})



func _on_retry_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file(Global.game_scene)
