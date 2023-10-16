extends ColorRect

@export var dialog_path : String = ""
@export var text_speed : float = 0.03
@export var punctuation_speed : float = 0.1

var dialog
var phrase_num : int = 0
var finished : bool = false

@onready var timer : Timer = $Timer
@onready var name_text : RichTextLabel = $Name
@onready var dialog_text : RichTextLabel = $Text
@onready var arrow : Polygon2D = $Arrow
@onready var sound : AudioStreamPlayer2D = $DialogueSound

var delayed_frame : bool = true

func _ready() -> void:
	timer.wait_time = text_speed
	dialog = get_dialog()
	assert(dialog, "Dialog was not found.")
	
	next_phrase()

func _process(_delta) -> void:
	if delayed_frame: delayed_frame = false; return # hacky fix for double action
	
	arrow.visible = finished
	if Input.is_action_just_pressed("Action"):
		if finished:
			next_phrase()
		else:
			dialog_text.visible_characters = len(dialog_text.text)

func get_dialog() -> Array:
	assert(FileAccess.file_exists(dialog_path), "File path does not exist.")
	
	var f = FileAccess.open(dialog_path, FileAccess.READ)
	var json_text = f.get_as_text()
	
	var data = JSON.parse_string(json_text)
	
	if typeof(data) == TYPE_ARRAY:
		return data
	else:
		return []

func next_phrase() -> void:
	if phrase_num == len(dialog):
		owner.queue_free()
		return
	
	finished = false
	
	name_text.bbcode_text = dialog[phrase_num]["Name"]
	dialog_text.bbcode_text = dialog[phrase_num]["Text"]
	
	var striped_text = util.strip_bbcode(dialog_text.text)
	dialog_text.visible_characters = 0
	
	while dialog_text.visible_characters < len(striped_text):
		dialog_text.visible_characters += 1
		
		sound.pitch_scale = randf_range(1.4,1.6)
		sound.play()
		
		var cur_letter = striped_text[dialog_text.visible_characters - 1]
		if cur_letter == "." or cur_letter == "," or cur_letter == "!":
			timer.wait_time = punctuation_speed
		else:
			timer.wait_time = text_speed
		
		timer.start()
		await timer.timeout
	
	finished = true
	phrase_num += 1
