extends Area2D

@onready var led_glow: Sprite2D = $LedGlow

@export var grid_pos: String = ""
@export_enum("none", "red", "green") var current_light: String = "none":
	set(value):
		current_light = value
		_update_light_visuals()

var connected_pin: Area2D = null

func _ready():
	_update_light_visuals()


func is_occupied():
	return connected_pin != null


func get_full_id():
	if current_light == "none":
		return grid_pos
	return grid_pos + "_" + current_light


func _update_light_visuals():
	if not led_glow:
		return
	
	if current_light == "none":
		led_glow.visible = false
	elif current_light == "red":
		led_glow.visible = true
		led_glow.modulate = Color(1.0, 0.0, 0.0)
	elif current_light == "green":
		led_glow.visible = true
		led_glow.modulate = Color(0.0, 1.0, 0.0)
