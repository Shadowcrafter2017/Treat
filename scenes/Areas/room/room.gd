extends Node2D

@onready var player : CharacterBody2D = $Player

func _ready() -> void:
	player.doing_action = true

func _on_dialogue_tree_exited():
	player.doing_action = false
