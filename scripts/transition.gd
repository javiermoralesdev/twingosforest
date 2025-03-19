extends CanvasLayer

signal on_transition_finished

func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_on_anim_finished)

func transition():
	visible = true
	$AnimationPlayer.play("fade_to_black")

func _on_anim_finished(anim_name: String):
	match anim_name:
		"fade_to_black":
			on_transition_finished.emit()
			$AnimationPlayer.play("fade_to_normal")
		"fade_to_normal":
			visible = false
