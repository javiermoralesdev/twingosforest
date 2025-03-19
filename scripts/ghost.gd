extends Area2D

@onready var target = %Player
const SPEED = 100
var health = 2

func _ready():
	pass

func _process(delta: float):
	if Global.paused:
		return
	if target == null:
		return
	if position.distance_to(target.position) > 3:
		var direction = Vector2(
			target.position.x - position.x,
			target.position.y - position.y
		).normalized()
		position += direction * SPEED * delta




func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("carrots"):
		health -= 1
		if health <= 0:
			queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		%GameOverScreen.appear()
		Global.paused = true
