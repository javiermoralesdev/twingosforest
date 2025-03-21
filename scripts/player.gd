extends CharacterBody2D

const SPEED = 150
@onready var target = position
@onready var carrot_prefab = preload("res://scenes/carrot.tscn")
@onready var tree_prefab = preload("res://scenes/tree.tscn")
var score = 0
var pause_hover = false

func _physics_process(_delta: float) -> void:
	%ScoreLabel.text = str(score)
	if Global.paused:
		%TargetImage.visible = false
		return
	if Input.is_action_just_pressed("move") and not pause_hover:
		target = get_global_mouse_position()
		%TargetImage.position = target
	if position.distance_to(target) > 3:
		go_to_target()
	else:
		$AnimationPlayer.play("idle")
		%TargetImage.visible = false
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	if Input.is_action_just_pressed("plant"):
		plant_tree()
	
	if Input.is_action_just_pressed("escape"):
		pause()
	
	move_and_slide()

func plant_tree():
	if are_trees_too_close():
		$WrongPlayer.play()
		return
	var tree_instance = tree_prefab.instantiate()
	tree_instance.position = position
	add_sibling(tree_instance)

func go_to_target():
	var direction = Vector2(
		target.x - position.x,
		target.y - position.y
	).normalized()
	%TargetImage.visible = true
	$AnimationPlayer.play("run")
	$PlayerSprite.flip_h = direction.x < 0
	velocity = direction * SPEED

func shoot():
	var carrot_instance = carrot_prefab.instantiate()
	carrot_instance.position = position
	var mouse_pos = get_global_mouse_position()
	var lookDir = mouse_pos - position
	var angle = atan2(lookDir.y, lookDir.x)
	carrot_instance.rotation = angle
	get_tree().root.add_child(carrot_instance)
	$ShootPlayer.play()

func are_trees_too_close() -> bool:
	var trees = get_tree().get_nodes_in_group("trees")
	for tree in trees:
		if position.distance_to(tree.position) < 200:
			return true
	return false


func _on_pause_button_pressed() -> void:
	pause()

func pause():
	if Global.paused:
		return
	%MusicPlayer.stream_paused = true
	Global.paused = true
	%PauseScreen.appear()
	%PauseButton.visible = false
	%ScoreLabel.visible = false


func _on_pause_button_mouse_entered() -> void:
	pause_hover = true


func _on_pause_button_mouse_exited() -> void:
	pause_hover = false
