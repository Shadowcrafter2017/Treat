extends CharacterBody2D

@export var move_speed : float = 300.0
@export var acceleration : float = 30.0

@onready var collect_sound : AudioStreamPlayer2D = $CollectSound
@onready var bad_collect_sound : AudioStreamPlayer2D = $BadCollectSound
@onready var HUD = get_tree().get_first_node_in_group("HUD")

func _physics_process(_delta) -> void:
	var direction : Vector2 = Vector2(Input.get_axis("Move_Left", "Move_Right"), 0)
	
	velocity.x = move_toward(velocity.x, move_speed * direction.x, acceleration)
	
	move_and_slide()

func _on_collection_area_body_entered(body : candy) -> void:
	Global.candy_collected += body.worth
	HUD.candy_updated(body.worth)
	
	if body.worth > 0:
		collect_sound.play()
	else:
		bad_collect_sound.play()
	
	body.animator.play("collected")
