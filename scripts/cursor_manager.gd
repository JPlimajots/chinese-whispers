extends Node

var hand_open = preload("res://assets/sprites/hand_open.png")
var hand_close = preload("res://assets/sprites/hand_close.png")
var hotspot = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(hand_open, Input.CURSOR_ARROW, hotspot)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				Input.set_custom_mouse_cursor(hand_close, Input.CURSOR_ARROW, hotspot)
			else:
				Input.set_custom_mouse_cursor(hand_open, Input.CURSOR_ARROW, hotspot)
