extends Node2D

@export var referenceLeft: Node2D
@export var referenceRight: Node2D
@export var referenceUp: Node2D
@export var referenceDown: Node2D

@onready var skeleton_prefab = preload("res://scenes/skeleton.tscn")
@onready var ghost_prefab = preload("res://scenes/ghost.tscn")

func _ready() -> void:
	randomize()
	Global.paused = false

func _on_enemy_timer_timeout() -> void:
	spawn_enemy(ghost_prefab)
	spawn_skeleton()

func get_coord_in_bounds() -> Vector2:
	var x = randi_range(referenceLeft.position.x, referenceRight.position.x)
	var y = randi_range(referenceUp.position.y, referenceDown.position.y)
	return Vector2(x, y)

func get_valid_coord() -> Vector2:
	var position = get_coord_in_bounds()
	while position.distance_to(%Player.position) < 300:
		position = get_coord_in_bounds()
	return position

func spawn_enemy(enemy: PackedScene):
	var position = get_valid_coord()
	var instance = enemy.instantiate()
	instance.position = position
	add_child(instance)

func spawn_skeleton():
	var trees = get_tree().get_node_count_in_group("trees")
	var skeletons = get_tree().get_node_count_in_group("skeletons")
	if skeletons < 2*trees and trees != 0:
		spawn_enemy(skeleton_prefab)
