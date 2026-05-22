extends CanvasLayer

@onready var dialogue_label: RichTextLabel = $MainControl/BalloonBackground/DialogueLabel
@onready var typewriter_timer: Timer = $TypewriterTimer
#@onready var log_container: VBoxContainer = $LogContainer

var current_text: String = ""
var current_char_index: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ConnectionManager.connection_success.connect(_on_connection_success)
	ConnectionManager.connection_chaos.connect(_on_connection_chaos)
	ConnectionManager.connection_dropped.connect(_on_connection_dropped)
	ConnectionManager.new_call_started.connect(display_current_hook)
	
	display_current_hook(ConnectionManager.current_call_id)


func display_current_hook(call_id: String):
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(call_id, {})
	if not call_data.is_empty():
		_start_typewriter(call_data["initial_text"])
	else:
		_start_typewriter("STATIC_NOISE_LINE_TEXT")


func _on_connection_success(caller_name: String, target_name: String):
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(ConnectionManager.current_call_id, {})
	if not call_data.is_empty():
		_start_typewriter(call_data["success_text"])


func _on_connection_chaos(caller_name: String, wrong_target_name: String, origin_id: String, target_id: String):
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(ConnectionManager.current_call_id, {})
	var chaos_data: Dictionary = call_data.get("wrong_targets", {}).get(target_id, {})
	
	if not chaos_data.is_empty():
		_start_typewriter(chaos_data["chaos_text"])


func _on_connection_dropped(caller_name: String, reason: String):
	_start_typewriter("LINE_MUTED: " + reason.to_upper())


func _start_typewriter(text_tag: String):
	current_text = text_tag
	dialogue_label.text = ""
	current_char_index = 0
	typewriter_timer.start()


func _on_typewriter_timer_timeout():
	if current_char_index < current_text.length():
		dialogue_label.text += current_text[current_char_index]
		current_char_index += 1
	else:
		typewriter_timer.stop()
