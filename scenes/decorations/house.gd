extends Node2D

@onready var sprite : AnimatedSprite2D = $StaticBody/Sprite

func _ready() -> void:
	sprite.frame = randi_range(0, sprite.sprite_frames.get_frame_count("default"))
	
	if randi_range(0,1) == 1:
		sprite.flip_h = true
