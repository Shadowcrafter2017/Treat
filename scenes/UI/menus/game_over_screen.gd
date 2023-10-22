extends Control

@onready var score_label : Label = $Panel/MarginContainer/VBoxContainer/ScoreLabel
@onready var play_button : Button = $Panel/MarginContainer/VBoxContainer/PlayButton

func _ready() -> void:
	play_button.grab_focus()
	score_label.text = "Candy collected: " + str(Global.candy_collected)

func _on_play_button_pressed():
	Global.costumed = false
	Global.candy_collected = 0
	get_tree().change_scene_to_file("res://scenes/UI/menus/main_menu/main_menu.tscn")
