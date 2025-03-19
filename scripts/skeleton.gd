extends Area2D


const SPEED = 150
var target: Node2D
var health = 2

func find_target():
	var trees = get_tree().get_nodes_in_group("trees")
	if trees.size() == 0:
		return
	var nearest = trees[0]
	for tree in trees:
		if position.distance_to(tree.position) < position.distance_to(nearest.position):
			nearest = tree
	target = nearest

func _process(delta: float) -> void:
	if Global.paused:
		return
	if target == null:
		find_target()
		return
	var direction = Vector2(
		target.position.x - position.x,
		target.position.y - position.y
	).normalized()
	if position.distance_to(target.position) > 3:
		position += direction * SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("carrots"):
		health -= 1
		if health <= 0:
			queue_free()
