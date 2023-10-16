extends CharacterBody2D

@export var move_speed : float = 300.0

func _physics_process(delta) -> void:
	var mouse_pos : Vector2 = get_global_mouse_position()
	var direction : Vector2 = (mouse_pos - global_position).normalized() * Vector2(1, 0)
	
	velocity = direction * move_speed
	move_and_slide()
