extends Area2D

@onready var led_glow: Sprite2D = $LedGlow
@onready var led_timer: Timer = $LedTimer

@export var grid_pos: String = ""

const COLOR_IDLE = Color("#ffb454")
const COLOR_RED = Color("#ff3333")
const COLOR_GREEN = Color("#33ff33")

var connected_pin: Area2D = null
var active_color: Color = COLOR_IDLE

func _ready():
	led_timer.timeout.connect(_on_led_timer_timeout)
	set_led_idle()
	if not grid_pos.begins_with("ADAPT"):
		add_to_group("panel_ports")


func is_occupied():
	return connected_pin != null


func get_full_id():
	return grid_pos


func set_led_idle():
	led_timer.stop()
	led_glow.visible = true
	led_glow.modulate = COLOR_IDLE
	active_color = COLOR_IDLE


func set_led_solid(color_str: String):
	led_timer.stop()
	led_glow.visible = true
	led_glow.modulate = COLOR_RED if color_str == "red" else COLOR_GREEN
	active_color = led_glow.modulate


func set_led_blinking(color_str: String, blink_speed: float):
	led_timer.stop()
	led_glow.visible = true
	active_color = COLOR_RED if color_str == "red" else COLOR_GREEN
	led_glow.modulate = active_color
	led_timer.wait_time = blink_speed
	led_timer.start()


func _on_led_timer_timeout():
	if led_glow.modulate == active_color:
		led_glow.modulate = Color.TRANSPARENT
	else:
		led_glow.modulate = active_color
		
