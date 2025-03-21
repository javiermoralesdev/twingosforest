extends CanvasLayer


func pause_anim():
	$AnimationPlayer.pause()

func _process(_delta: float):
	if Input.is_action_just_pressed("move") and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("story")
	if Input.is_action_just_pressed("shoot"):
		skip()

func skip():
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file(Global.game_scene)
