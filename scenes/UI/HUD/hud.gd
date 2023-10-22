extends CanvasLayer

@export var increment_label : PackedScene
@onready var candy_label : Label = $Control/Margin/Split/CandyContainer/HBoxContainer/Label
@onready var candy_hbox : HBoxContainer = $Control/Margin/Split/CandyContainer/HBoxContainer
@onready var clock_label : Label = $Control/Margin/Split/CandyContainer/Clock/Label

func _process(_delta) -> void:
	if not Global.game_timer.is_stopped():
		var time_left : String = str(60 - int(Global.game_timer.time_left))
		
		if len(time_left) == 1:
			time_left = '0' + time_left
		
		if time_left == '60':
			clock_label.text = "6:00 PM"
			await get_tree().create_timer(3).timeout
			SceneTransition.change_scene("res://scenes/UI/menus/game_over_screen.tscn")
		else:
			clock_label.text = "5:%s PM" % time_left

func candy_updated(increment : int) -> void:
	candy_label.text = str(Global.candy_collected)
	
	var incrementer : Node2D = increment_label.instantiate()
	candy_hbox.add_child(incrementer)
	
	if increment > 0:
		incrementer.get_child(0).text = '+' + str(increment)
	else:
		incrementer.get_child(0).text = str(increment)
