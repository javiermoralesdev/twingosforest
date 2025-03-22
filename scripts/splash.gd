extends TextureRect

func _init():
	if Global.first_run:
		queue_free()
	visible = true

func _ready() -> void:
	Global.first_run = true
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), .5)
	tween.tween_callback(queue_free)
