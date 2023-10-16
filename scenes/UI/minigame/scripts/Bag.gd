extends CharacterBody2D

@export var move_speed : float = 300.0

var candy_count : int = 0

func _physics_process(_delta) -> void:
	var mouse_pos : Vector2 = get_global_mouse_position()
	var direction : Vector2 = (mouse_pos - global_position).normalized() * Vector2(1, 0)
	
	velocity = direction * move_speed
	move_and_slide()

func _on_collection_area_body_entered(body : candy) -> void:
	candy_count += body.worth
	body.animator.play("collected")
