extends Control

@onready var score_label : Label = $Panel/MarginContainer/VBoxContainer/ScoreLabel
@onready var menu_button : Button = $Panel/MarginContainer/VBoxContainer/MenuButton

func _ready() -> void:
	menu_button.grab_focus()
	score_label.text = "Candy collected: " + str(Global.candy_collected)

func _on_play_button_pressed():
	Global.costumed = false
	Global.candy_collected = 0
	SceneTransition.change_scene("res://scenes/UI/menus/main_menu/main_menu.tscn")
