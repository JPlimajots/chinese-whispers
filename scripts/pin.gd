extends Area2D

signal pin_canceled

var is_dragging: bool = false
var connected_port: Area2D = null
var home_position: Vector2 = Vector2.ZERO
var is_returning: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	home_position = global_position


func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event.is_action_pressed("interact_plug"):
		is_dragging = true
		disconnect_from_port()
	
	elif event.is_action_pressed("interact_cancel"):
		is_dragging = false
		pin_canceled.emit()


func _input(event: InputEvent):
	if is_dragging and event.is_action_released("interact_plug"):
		is_dragging = false
		_check_drop_zone()


func _check_drop_zone():
	var overlapping_areas = get_overlapping_areas()
	
	for area in overlapping_areas:
		if area.is_in_group("ports"):
			if area.has_method("is_occupied") and area.is_occupied():
				continue
			connected_port = area
			area.connected_pin = self
			global_position = area.global_position
			return


func disconnect_from_port():
	if connected_port:
		connected_port.connected_pin = null
		connected_port = null
