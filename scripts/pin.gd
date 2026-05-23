extends Area2D

signal pin_canceled

@export var red_pin_texture: Texture2D
@export var green_pin_texture: Texture2D
@export var red_connected_texture: Texture2D
@export var green_connected_texture: Texture2D

@onready var pin_sprite: Sprite2D = $Sprite2D
@onready var anchor_normal: Marker2D = $WireAnchorNormal
@onready var anchor_connected: Marker2D = $WireAnchorConnected
@onready var col_normal: CollisionShape2D = $CollisionNormal
@onready var col_connected: CollisionShape2D = $CollisionConnected

var is_dragging: bool = false
var connected_port: Area2D = null
var home_position: Vector2 = Vector2.ZERO
var is_returning: bool = false
var base_rotation: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_rotation = rotation
	home_position = global_position
	var parent_cable = get_parent()
	
	if parent_cable and "cable_color" in parent_cable:
		if parent_cable.cable_color == "red":
			pin_sprite.texture = red_pin_texture
		elif parent_cable.cable_color == "green":
			pin_sprite.texture = green_pin_texture
	
	update_visuals()


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
			ConnectionManager.evaluate_new_connection(area)
			update_visuals()
			return


func disconnect_from_port():
	if connected_port:
		connected_port.connected_pin = null
		connected_port = null
		update_visuals()


func get_wire_pos():
	if connected_port != null and anchor_connected:
		return anchor_connected.global_position
	elif anchor_normal:
		return anchor_normal.global_position
	return global_position


func get_wire_offset():
	if connected_port != null and anchor_connected:
		return anchor_connected.global_position - global_position
	elif anchor_normal:
		return anchor_normal.global_position - global_position
	return Vector2.ZERO


func update_visuals():
	var parent_cable = get_parent()
	if not parent_cable or not "cable_color" in parent_cable:
		return
	
	if connected_port != null:
		col_normal.set_deferred("disabled", true)
		col_connected.set_deferred("disabled", false)
		
		if "pin_2" in parent_cable and parent_cable.pin_2 == self:
			rotation = 0.0
		
		if parent_cable.cable_color == "red":
			pin_sprite.texture = red_connected_texture
		else:
			pin_sprite.texture = green_connected_texture
	else:
		col_connected.set_deferred("disabled", true)
		col_normal.set_deferred("disabled", false)
		
		rotation = base_rotation
		
		if parent_cable.cable_color == "red":
			pin_sprite.texture = red_pin_texture
		else:
			pin_sprite.texture = green_pin_texture
