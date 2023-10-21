class_name candy extends RigidBody2D

@export_enum("red", "orange", "yellow", "green", "blue", "purple") var candy_type

var worth : int

@onready var sprite : Sprite2D = $Sprite
@onready var animator : AnimationPlayer = $Animator

func _ready() -> void:
	candy_type = randi_range(0, 5)
	
	match candy_type:
		0: # red
			sprite.modulate = Color.RED
			worth = randi_range(-1, -15)
		1: # orange
			sprite.modulate = Color.ORANGE
			worth = 1
		2: # yellow
			sprite.modulate = Color.YELLOW
			worth = 2
		3: #green
			sprite.modulate = Color.GREEN
			worth = 4
		4: #blue
			sprite.modulate = Color.BLUE
			worth = 5
		5: #purple
			sprite.modulate = Color.PURPLE
			worth = 10
	
	linear_velocity = Vector2(randf(), randf()) * randf_range(-300.0,300.0)
	angular_velocity = randf_range(-5.0,5.0)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void: #mouthfull
	animator.play("collected")
