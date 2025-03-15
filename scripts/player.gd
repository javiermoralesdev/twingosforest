extends CharacterBody2D

const SPEED = 150
@onready var target = position
@onready var carrot_prefab = preload("res://scenes/carrot.tscn")

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("move"):
		target = get_global_mouse_position()
		%TargetImage.position = target
		%TargetImage.visible = true
	if position.distance_to(target) > 3:
		var direction = Vector2(
		target.x - position.x,
		target.y - position.y
		).normalized()
		$AnimationPlayer.play("run")
		$PlayerSprite.flip_h = direction.x < 0
		velocity = direction * SPEED
	else:
		$AnimationPlayer.play("idle")
		%TargetImage.visible = false
		velocity = Vector2.ZERO
		
	
	if Input.is_action_just_pressed("shoot"):
		var carrot_instance = carrot_prefab.instantiate()
		carrot_instance.position = position
		var mouse_pos = get_global_mouse_position()
		var lookDir = mouse_pos - position
		var angle = atan2(lookDir.y, lookDir.x)
		carrot_instance.rotation = angle
		get_tree().root.add_child(carrot_instance)
	move_and_slide()
