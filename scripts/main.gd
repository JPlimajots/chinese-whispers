extends Node2D

@onready var dialogue_ui = $DialogueUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()


func _on_invisible_notebook_button_pressed() -> void:
	print(">> [INTERFACE] Botão invisível clicado!")
	dialogue_ui.show_notebook()
