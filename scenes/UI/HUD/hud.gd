extends CanvasLayer

@export var increment_label : PackedScene
@onready var candy_label : Label = $Control/Margin/Split/CandyContainer/HBoxContainer/Label
@onready var candy_hbox : HBoxContainer = $Control/Margin/Split/CandyContainer/HBoxContainer
func _ready() -> void:
	pass
	
func candy_updated(increment : int) -> void:
	candy_label.text = str(Global.candy_collected)
	
	var incrementer : Node2D = increment_label.instantiate()
	candy_hbox.add_child(incrementer)
	
	if increment > 0:
		incrementer.get_child(0).text = '+' + str(increment)
	else:
		incrementer.get_child(0).text = str(increment)
