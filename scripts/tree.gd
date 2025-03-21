extends Area2D

enum TreeState {
	BASE = 12,
	GROW = 3,
	FRUITS = 4
}
var dying = false

var state = TreeState.BASE

func _process(_delta: float):
	$TreeSprite.frame = state

func _on_grow_timer_timeout() -> void:
	match state:
		TreeState.BASE: state = TreeState.GROW
		TreeState.GROW: state = TreeState.FRUITS
	
	if state != TreeState.FRUITS:
		$GrowTimer.start()

func has_skeletons() -> bool:
	var areas = get_overlapping_areas()
	for area in areas:
		if area.is_in_group("skeletons") :
			if not area.is_queued_for_deletion():
				return true
	return false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" && state == TreeState.FRUITS:
		state = TreeState.GROW
		body.score += 1
		$GrowTimer.start()


func _on_attack_timer_timeout() -> void:
	$FallPlayer.play()
	match state:
		TreeState.BASE: dying = true
		TreeState.GROW: state = TreeState.BASE
		TreeState.FRUITS: state = TreeState.GROW


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("skeletons"):
		$AttackTimer.start()
		$GrowTimer.paused = true


func _on_area_exited(area: Area2D) -> void:
	if is_queued_for_deletion():
		return
	if area.is_in_group("skeletons"):
		if not has_skeletons():
			$AttackTimer.stop()
			$GrowTimer.paused = false


func _on_fall_player_finished() -> void:
	if dying:
		queue_free()
