extends CharacterBody2D

@export var candy_minigame : PackedScene
@export var dialogue_scene : PackedScene
@export var move_speed : float = 42.0

var doing_action : bool = false #for disabling input

@onready var sprite : Sprite2D = $Sprite
@onready var interaction_label : Label = $Interacter/InteractionLabel
@onready var animator : AnimationPlayer = $Animator
@onready var interactions : Array = []

func _physics_process(_delta) -> void:
	if not doing_action:
		move_player()
		do_interaction()

func move_player() -> void:
	var move_direction : Vector2 = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	if move_direction.x > 0 and sprite.flip_h:
		sprite.flip_h = false
	elif move_direction.x < 0 and not sprite.flip_h:
		sprite.flip_h = true
	
	
	velocity = move_speed * move_direction
	
	if velocity != Vector2.ZERO and not animator.is_playing():
		animator.play("walk")
	elif velocity == Vector2.ZERO and animator.is_playing():
		animator.stop()
	
	move_and_slide()

func update_interactions() -> void:
	if interactions:
		interaction_label.text = interactions[0].interact_text
	else:
		interaction_label.text = ""

func do_interaction() -> void:
	if interactions and Input.is_action_just_pressed("Action"):
		var current_interaction : Interaction_Area = interactions[0]
		match current_interaction.interact_type:
			"Dialogue":
				doing_action = true
				
				var dialog_box : CanvasLayer = dialogue_scene.instantiate()
				dialog_box.get_child(0).dialog_path = current_interaction.interact_value
				owner.add_child(dialog_box)
				
				await dialog_box.tree_exited
				doing_action = false
			"Knock":
				doing_action = true
				
				var minigame : CanvasLayer = candy_minigame.instantiate()
				owner.add_child(minigame)
				
				var candy_spawner : Node2D = get_tree().get_first_node_in_group("CandySpawner")
				candy_spawner.amount_to_spawn = randi_range(10,30)
				
				await minigame.tree_exited
				doing_action = false
			"Use":
				print("Take: " + current_interaction.interact_value)

func _on_interacter_area_area_entered(area) -> void:
	interactions.insert(0, area)
	update_interactions()

func _on_interacter_area_area_exited(area) -> void:
	interactions.erase(area)
	update_interactions()
