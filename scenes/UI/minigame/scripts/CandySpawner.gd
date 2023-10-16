extends Node2D

@export var candy_scene : PackedScene
@export var amount_to_spawn : int

@onready var spawn_point : PathFollow2D = $SpawnPath/Follow

func _ready() -> void:
	for i in range(amount_to_spawn):
		spawn_candy()
		await get_tree().create_timer(randf_range(0.0,1.0)).timeout

func spawn_candy() -> void:
	spawn_point.progress_ratio = randf()
	
	var candy : RigidBody2D = candy_scene.instantiate()
	candy.global_position = spawn_point.position
	add_child(candy)
