extends Control

const COLOR_IDLE = Color("#ffb454")
const COLOR_RED = Color("#ff3333")
const COLOR_GREEN = Color("#33ff33")

@onready var vbox = $VBoxContainer
@onready var logo_led_1: Sprite2D = $Logo/LogoLed1
@onready var logo_led_2: Sprite2D = $Logo/LogoLed2
@onready var logo_timer: Timer = $LogoTimer
@onready var tutorial_popup: Panel = $TutorialPopup
@onready var close_tutorial_button: Button = $TutorialPopup/CloseTutorialButton

var normal_scale := Vector2(1.0, 1.0)
var hover_scale := Vector2(1.05, 1.05) 
var pressed_scale := Vector2(0.95, 0.95) 
var tween_time := 0.1 
var is_state_a: bool = true

func _ready() -> void:
	for button in vbox.get_children():
		if button is TextureButton:
			button.pivot_offset = button.size / 2.0
			button.mouse_entered.connect(_on_button_hovered.bind(button))
			button.mouse_exited.connect(_on_button_exited.bind(button))
			button.button_down.connect(_on_button_pressed.bind(button))
			button.button_up.connect(_on_button_released.bind(button))
	logo_led_1.modulate = COLOR_RED
	logo_led_2.modulate = COLOR_GREEN
	logo_timer.timeout.connect(_on_logo_timer_timeout)
	tutorial_popup.hide()
	close_tutorial_button.pressed.connect(_on_close_tutorial_button_pressed)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")



func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_close_tutorial_button_pressed() -> void:
	tutorial_popup.hide()


func _animate_scale(button: TextureButton, target_scale: Vector2):
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(button, "scale", target_scale, tween_time)


func _on_button_hovered(button: TextureButton):
	_animate_scale(button, hover_scale)
	
	
func _on_button_exited(button: TextureButton):
	_animate_scale(button, normal_scale)


func _on_button_pressed(button: TextureButton):
	_animate_scale(button, pressed_scale)


func _on_button_released(button: TextureButton):
	_animate_scale(button, hover_scale)


func _on_logo_timer_timeout() -> void:
	if is_state_a:
		logo_led_1.modulate = COLOR_IDLE
		logo_led_2.modulate = COLOR_GREEN
	else:
		logo_led_1.modulate = COLOR_RED
		logo_led_2.modulate = COLOR_IDLE
	is_state_a = !is_state_a


func _on_tutorial_button_pressed() -> void:
	tutorial_popup.show()
