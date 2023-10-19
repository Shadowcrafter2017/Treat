extends CharacterBody2D

@export var move_speed : float = 300.0
@export var acceleration : float = 30.0

var candy_count : int = 0

func _physics_process(_delta) -> void:
	var direction : Vector2 = Vector2(Input.get_axis("Move_Left", "Move_Right"), 0)
	
	velocity.x = move_toward(velocity.x, move_speed * direction.x, acceleration)
	velocity.y = move_toward(velocity.y, move_speed * direction.y, acceleration)
	
	move_and_slide()

func _on_collection_area_body_entered(body : candy) -> void:
	candy_count += body.worth
	body.animator.play("collected")
