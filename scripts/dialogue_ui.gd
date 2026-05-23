extends CanvasLayer

@onready var caller_balloon = $MainControl/CallerBalloon
@onready var caller_label = $MainControl/CallerBalloon/CallerLabel
@onready var receiver_balloon = $MainControl/ReceiverBalloon
@onready var receiver_label = $MainControl/ReceiverBalloon/ReceiverLabel
@onready var typewriter_timer: Timer = $TypewriterTimer
#@onready var log_container: VBoxContainer = $LogContainer

var current_text: String = ""
var current_char_index: int = 0
var active_label: RichTextLabel = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	caller_balloon.hide()
	receiver_balloon.hide()
	
	ConnectionManager.connection_success.connect(_on_connection_success)
	ConnectionManager.connection_chaos.connect(_on_connection_chaos)
	ConnectionManager.connection_dropped.connect(_on_connection_dropped)
	ConnectionManager.new_call_started.connect(display_current_hook)
	ConnectionManager.clear_ui_text.connect(_clear_text)
	
	display_current_hook(ConnectionManager.current_call_id)


func display_current_hook(call_id: String):
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(call_id, {})
	if not call_data.is_empty():
		_start_typewriter(call_data["initial_text"], caller_balloon, caller_label)
	else:
		_start_typewriter("STATIC_NOISE_LINE_TEXT", caller_balloon, caller_label)


func _on_connection_success(caller_name: String, target_name: String):
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(ConnectionManager.current_call_id, {})
	if not call_data.is_empty():
		_start_typewriter(call_data["success_text"], receiver_balloon, receiver_label)


func _on_connection_chaos(caller_name: String, wrong_target_name: String, origin_id: String, target_id: String):
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(ConnectionManager.current_call_id, {})
	var chaos_data: Dictionary = call_data.get("wrong_targets", {}).get(target_id, {})
	
	if not chaos_data.is_empty():
		_start_typewriter(chaos_data["chaos_text"], receiver_balloon, receiver_label)


func _on_connection_dropped(caller_name: String, reason: String):
	_start_typewriter("LINE_MUTED: " + reason.to_upper(), receiver_balloon, receiver_label)


func _start_typewriter(text_tag: String, target_balloon: Control, target_label: RichTextLabel):
	ConnectionManager.is_typing = true
	current_text = text_tag
	current_char_index = 0
	active_label = target_label
	active_label.text = ""
	target_balloon.show()
	typewriter_timer.start()


func _on_typewriter_timer_timeout():
	if active_label and current_char_index < current_text.length():
		active_label.text += current_text[current_char_index]
		current_char_index += 1
	else:
		typewriter_timer.stop()
		ConnectionManager.is_typing = false
		ConnectionManager.typing_finished.emit()


func _clear_text():
	caller_label.text = ""
	receiver_label.text = ""
	caller_balloon.hide()
	receiver_balloon.hide()
