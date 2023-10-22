extends Control

@onready var start_button : Button = $MarginContainer/VBoxContainer/Start
@onready var quit_button : Button = $MarginContainer/VBoxContainer/Quit

func _ready():
	start_button.grab_focus()

func _on_start_pressed():
	SceneTransition.change_scene("res://scenes/Areas/room/room.tscn")

func _on_quit_pressed():
	get_tree().quit()
