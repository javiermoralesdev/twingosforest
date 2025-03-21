extends ColorRect

func _ready() -> void:
	$PauseAnim.animation_finished.connect(_on_anim_finished)

func appear():
	visible = true
	$PauseAnim.play("show")


func _on_button_pressed() -> void:
	%PauseButton.visible = true
	%ScoreLabel.visible = true
	$PauseAnim.play("hide")
	Global.paused = false
	%MusicPlayer.stream_paused = false

func main_menu():
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file(Global.menu_scene)

func _on_anim_finished(anim_name: String):
	match anim_name:
		"hide": visible = false
