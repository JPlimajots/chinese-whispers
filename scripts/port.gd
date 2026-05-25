extends Area2D

@onready var led_glow: Sprite2D = $LedGlow
@onready var led_timer: Timer = $LedTimer

@export var grid_pos: String = ""
@export var has_leds: bool = true

const COLOR_IDLE = Color("#ffb454")
const COLOR_RED = Color("#ff3333")
const COLOR_GREEN = Color("#33ff33")

var connected_pin: Area2D = null
var active_color: Color = COLOR_IDLE

func _ready():
	led_timer.timeout.connect(_on_led_timer_timeout)
	if not has_leds:
		led_glow.hide()
	else:
		set_led_idle()
	if not grid_pos.begins_with("ADAPT"):
		add_to_group("panel_ports")


func is_occupied():
	return connected_pin != null


func get_full_id():
	return grid_pos


func set_led_idle():
	led_timer.stop()
	active_color = COLOR_IDLE
	if not has_leds:
		led_glow.hide()
		return
	led_glow.visible = true
	led_glow.modulate = COLOR_IDLE


func set_led_solid(color_str: String):
	led_timer.stop()
	active_color = COLOR_RED if color_str == "red" else COLOR_GREEN
	if not has_leds:
		led_glow.hide()
		return
	led_glow.visible = true
	led_glow.modulate = active_color
	AudioManager.play_foley("relay")


func set_led_blinking(color_str: String, blink_speed: float):
	led_timer.stop()
	active_color = COLOR_RED if color_str == "red" else COLOR_GREEN
	if not has_leds:
		led_glow.hide()
		return
	led_glow.visible = true
	led_glow.modulate = active_color
	led_timer.wait_time = blink_speed
	led_timer.start()


func _on_led_timer_timeout():
	if led_glow.modulate == active_color:
		led_glow.modulate = Color.TRANSPARENT
	else:
		led_glow.modulate = active_color
		
