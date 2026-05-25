extends Node2D

@onready var dialogue_ui = $DialogueUI
@onready var end_game_panel: Panel = $EndGamePanel
@onready var message_label: RichTextLabel = $EndGamePanel/MessageLabel
@onready var menu_button: Button = $EndGamePanel/MenuButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	end_game_panel.hide()
	menu_button.pressed.connect(_on_menu_button_pressed)
	ConnectionManager.shift_ended.connect(_on_day_completed)
	ConnectionManager.game_over.connect(_on_game_over)
	call_deferred("_initialize_game")


func _initialize_game() -> void:
	NarrativeManager.reset_call_pool()
	ConnectionManager.lost_calls_count = 0
	ConnectionManager.current_call_id = ""
	ConnectionManager.call_resolved = false
	ConnectionManager.is_typing = false
	ConnectionManager.is_patience_ticking = false
	ConnectionManager.is_ringing = false
	ConnectionManager.current_patience = ConnectionManager.max_patience
	ConnectionManager.start_first_call()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
	

func _on_invisible_notebook_button_pressed() -> void:
	dialogue_ui.show_notebook()


func _on_day_completed() -> void:
	var text = "[center][b][font_size=24]SHIFT COMPLETED[/font_size][/b]\n\n"
	text += "Congratulations! You survived your experimental shift and successfully routed the calls.\n"
	text += "The corporation is pleased with your efficiency. [b]You are officially hired![/b]\n"
	_trigger_end_transition(text)


func _on_game_over() -> void:
	var text = "[center][b][font_size=24]GAME OVER[/font_size][/b]\n\n"
	text += "You have been summarily fired.\n"
	text += "Your performance fell severely below corporate standards, and the HR department has terminated your contract immediately.\n"
	_trigger_end_transition(text)


func _trigger_end_transition(outcome_text: String) -> void:
	outcome_text += "\n\n\n---"
	outcome_text += "\nThank you so much for playing our game! We hope you enjoyed operating the switchboard as much as we enjoyed creating it."
	outcome_text += "\n- The Dev Team[/center]"
	message_label.bbcode_enabled = true
	message_label.text = outcome_text
	end_game_panel.modulate.a = 0.0
	end_game_panel.show()
	menu_button.disabled = true
	var tween = create_tween()
	tween.tween_property(end_game_panel, "modulate:a", 1.0, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(func(): menu_button.disabled = false)


func _on_menu_button_pressed() -> void:
	ConnectionManager.lost_calls_count = 0
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
