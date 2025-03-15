extends Area2D

const SPEED = 300

func _physics_process(delta: float) -> void:
	var direction = Vector2(
		cos(rotation),
		sin(rotation)
	)
	
	position += direction * SPEED * delta

func _on_lifetime_timer_timeout() -> void:
	queue_free()
