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
	Engine.time_scale = 1

func _on_anim_finished(anim_name: String):
	match anim_name:
		"hide": visible = false
