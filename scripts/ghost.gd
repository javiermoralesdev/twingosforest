extends Area2D

@onready var target = get_tree().get_first_node_in_group("player")
const SPEED = 100
var health = 2

func _process(delta: float):
	if Global.paused:
		return
	if target == null:
		target = get_tree().get_first_node_in_group("player")
		return
	if position.distance_to(target.position) > 3:
		var direction = Vector2(
			target.position.x - position.x,
			target.position.y - position.y
		).normalized()
		$GhostSprite.flip_h = direction.x < 0
		position += direction * SPEED * delta




func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("carrots"):
		health -= 1
		if health <= 0:
			$DiePlayer.play()
			$CollisionShape2D.set_deferred("disabled", true)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_node("/root/Game/CanvasLayer/GameOverScreen").appear()
		Global.paused = true


func _on_die_player_finished() -> void:
	queue_free()
