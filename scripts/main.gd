extends Node2D

@onready var dialogue_ui = $DialogueUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(">> [MESA] Carregando...")
	call_deferred("_initialize_game")


func _initialize_game() -> void:
	print(">> [MESA] Grupos de portas criados. Iniciando o ConnectionManager...")
	ConnectionManager.start_first_call()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
	

func _on_invisible_notebook_button_pressed() -> void:
	print(">> [INTERFACE] Botão invisível clicado!")
	dialogue_ui.show_notebook()
