extends CanvasLayer

@onready var caller_balloon = $MainControl/CallerBalloon
@onready var caller_label = $MainControl/CallerBalloon/CallerLabel
@onready var receiver_balloon = $MainControl/ReceiverBalloon
@onready var receiver_label = $MainControl/ReceiverBalloon/ReceiverLabel
@onready var typewriter_timer: Timer = $TypewriterTimer
@onready var caller_portrait: TextureRect = $MainControl/CallerPortrait
@onready var receiver_portrait: TextureRect = $MainControl/ReceiverPortrait
@onready var caller_name_label: Label = $MainControl/CallerNameBox/Label
@onready var caller_name_box: Control = $MainControl/CallerNameBox
@onready var receiver_name_label: Label = $MainControl/ReceiverNameBox/Label
@onready var receiver_name_box: Control = $MainControl/ReceiverNameBox
@onready var open_notebook_ui: Control = $MainControl/OpenNotebookUI

var current_text: String = ""
var current_char_index: int = 0
var active_label: RichTextLabel = null
var current_talking_character: String = ""
var is_mouth_open: bool = false
var active_portrait: TextureRect = null
var current_lines: PackedStringArray = []
var current_line_index: int = 0
var is_waiting_for_next_line: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	caller_balloon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	caller_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# Se você tiver os nós do receiver, adicione também:
	receiver_balloon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	receiver_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	caller_balloon.hide()
	receiver_balloon.hide()
	caller_portrait.hide()   
	receiver_portrait.hide() 
	caller_name_box.hide()   
	receiver_name_box.hide() 
	
	ConnectionManager.connection_success.connect(_on_connection_success)
	ConnectionManager.connection_chaos.connect(_on_connection_chaos)
	ConnectionManager.connection_dropped.connect(_on_connection_dropped)
	ConnectionManager.new_call_started.connect(display_current_hook)
	ConnectionManager.clear_ui_text.connect(_clear_text)
	ConnectionManager.caller_lost_patience.connect(_on_caller_lost_patience)
	
	display_current_hook(ConnectionManager.current_call_id)


func display_current_hook(call_id: String):
	print("--- DEBUG DO REMETENTE (CALLER) ---")
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(call_id, {})
	print("Chaves disponíveis no dicionário da chamada: ", call_data.keys())
	var caller_port = call_data.get("caller_id", "")
	var caller_name = NarrativeManager.PORT_DIRECTORY.get(caller_port, {}).get("default_character", "")
	print("Nome do Remetente extraído: '", caller_name, "'")
	if not call_data.is_empty():
		_start_typewriter(call_data["initial_text"], caller_balloon, caller_label, caller_name, caller_portrait)
	else:
		_start_typewriter("STATIC_NOISE_LINE_TEXT", caller_balloon, caller_label, "", caller_portrait)


func _on_connection_success(caller_name: String, target_name: String):
	print("--- DEBUG DO DESTINATÁRIO (RECEIVER) ---")
	print("O sinal informou que a porta conectada foi: '", target_name, "'")
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(ConnectionManager.current_call_id, {})
	if not call_data.is_empty():
		var receiver_name = _get_character_by_location(target_name)
		print("Nome do Destinatário encontrado no PORT_DIRECTORY: '", receiver_name, "'")
		_start_typewriter(call_data["success_text"], receiver_balloon, receiver_label, receiver_name, receiver_portrait)


func _on_connection_chaos(caller_name: String, wrong_target_name: String, origin_id: String, target_id: String):
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(ConnectionManager.current_call_id, {})
	var chaos_data: Dictionary = call_data.get("wrong_targets", {}).get(target_id, {})
	
	if not chaos_data.is_empty():
		var receiver_name = _get_character_by_location(wrong_target_name)
		_start_typewriter(chaos_data["chaos_text"], receiver_balloon, receiver_label, receiver_name, receiver_portrait)


func _on_connection_dropped(caller_name: String, reason: String):
	_start_typewriter("LINE_MUTED: " + reason.to_upper(), receiver_balloon, receiver_label, "", receiver_portrait)


func _start_typewriter(text_tag: String, target_balloon: Control, target_label: RichTextLabel, character_name: String, target_portrait: TextureRect):
	ConnectionManager.is_typing = true
	current_lines = text_tag.split("\n")
	current_line_index = 0
	is_waiting_for_next_line = false
	active_label = target_label
	current_talking_character = character_name
	active_portrait = target_portrait
	
	var name_label: Label = null
	var name_box: Control = null
	
	if target_balloon == caller_balloon:
		name_label = caller_name_label
		name_box = caller_name_box
	else:
		name_label = receiver_name_label
		name_box = receiver_name_box
	
	if character_name != "" and name_label != null:
		name_label.text = character_name
		name_box.show()
	elif name_box != null:
		name_box.hide()
	
	if character_name != "" and NarrativeManager.CHARACTER_SPRITES.has(character_name):
		var sprite = NarrativeManager.CHARACTER_SPRITES[character_name]
		if sprite["idle"] != null:
			target_portrait.texture = sprite["idle"]
			target_portrait.show()
	else:
		target_portrait.hide()
	target_balloon.show()
	_type_next_line()


func _on_typewriter_timer_timeout():
	if active_label and current_char_index < current_text.length():
		var current_char = current_text[current_char_index]
		active_label.text += current_char
		current_char_index += 1
		if current_char != " ":
			is_mouth_open = !is_mouth_open
			if current_talking_character != "" and NarrativeManager.CHARACTER_SPRITES.has(current_talking_character):
				var sprites = NarrativeManager.CHARACTER_SPRITES[current_talking_character]
				if sprites["talk"] != null and active_portrait != null:
					if is_mouth_open:
						active_portrait.texture = sprites["talk"]
					else:
						active_portrait.texture = sprites["idle"]
	else:
		typewriter_timer.stop()

		if current_talking_character != "" and NarrativeManager.CHARACTER_SPRITES.has(current_talking_character):
			var sprites = NarrativeManager.CHARACTER_SPRITES[current_talking_character]
			if active_portrait != null and sprites["idle"] != null:
				active_portrait.texture = sprites["idle"]
		
		if current_line_index < current_lines.size() - 1:
			is_waiting_for_next_line = true
		else:
			ConnectionManager.is_typing = false
			ConnectionManager.typing_finished.emit()


func _clear_text():
	caller_label.text = ""
	receiver_label.text = ""
	caller_balloon.hide()
	receiver_balloon.hide()
	
	caller_portrait.texture = null
	receiver_portrait.texture = null
	caller_portrait.hide()
	receiver_portrait.hide()
	caller_name_box.hide()
	receiver_name_box.hide()


func _get_character_by_location(target_location: String):
	for port_data in NarrativeManager.PORT_DIRECTORY.values():
		if port_data.get("location") == target_location:
			return port_data.get("default_character", "")
	return ""
	


func _type_next_line():
	current_text = current_lines[current_line_index]
	current_char_index = 0
	active_label.text = ""
	is_mouth_open = false
	
	if current_talking_character != "" and NarrativeManager.CHARACTER_SPRITES.has(current_talking_character):
		var sprite = NarrativeManager.CHARACTER_SPRITES[current_talking_character]
		if sprite["idle"] != null:
			active_portrait.texture = sprite["idle"]
			active_portrait.show()
	else:
		active_portrait.hide()
	
	typewriter_timer.start()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact_confirm") and is_waiting_for_next_line:
		is_waiting_for_next_line = false
		current_line_index += 1
		_type_next_line()


func _on_caller_lost_patience(text: String, character_name: String):
	receiver_balloon.hide()
	receiver_portrait.hide()
	receiver_name_box.hide()
	_start_typewriter(text, caller_balloon, caller_label, character_name, caller_portrait)


func show_notebook():
	open_notebook_ui.show()
	


func _on_close_button_pressed() -> void:
	open_notebook_ui.hide()
