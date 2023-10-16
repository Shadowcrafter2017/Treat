extends Node2D

@export var candy_scene : PackedScene
@export var amount_to_spawn : int

@onready var spawn_point : PathFollow2D = $SpawnPath/Follow
@onready var timer : Timer = $Timer

func _on_timer_timeout():
	if amount_to_spawn > 0:
		amount_to_spawn -= 1
		spawn_candy()
		
		timer.wait_time = randf_range(0.0, 1.0)
		timer.start()
	if amount_to_spawn == 0:
		await get_tree().create_timer(1.5).timeout
		owner.queue_free()

func spawn_candy() -> void:
	spawn_point.progress_ratio = randf()
	
	var candy : RigidBody2D = candy_scene.instantiate()
	candy.global_position = spawn_point.position
	add_child(candy)
