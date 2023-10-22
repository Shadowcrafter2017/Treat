extends Node2D

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	player.doing_action = true

func _on_dialogue_tree_exited():
	player.doing_action = false
	Global.game_timer.start()
