extends Node2D

@onready var wire: Line2D = $Wire
@onready var pin_1: Area2D = $Pin1
@onready var pin_2: Area2D = $Pin2

@export var num_segments: int = 9
@export var stiffness: int = 30 
@export var gravity_y: float = 2800.0
@export var damping: float = 0.94 

@export var wire_width_base: float = 5.0
@export var wire_width_connected: float = 12.0
@export_range(0.0, 5.0) var funnel_lenght_ratio: float = 0.1

@export_enum("red", "green") var cable_color: String = "red"
@export var red_cable_texture: Texture2D
@export var green_cable_texture: Texture2D

var max_length: float = 0.0
var gravity: Vector2 = Vector2.ZERO
var segment_length: float = 0.0
var pos_current: Array[Vector2] = []
var pos_old: Array[Vector2] = []
var funnel_curve: Curve


func _ready() -> void:
	if cable_color == "red":
		wire.texture = red_cable_texture
	elif cable_color == "green":
		wire.texture = green_cable_texture
	
	gravity = Vector2(0, gravity_y)
	max_length = pin_1.get_wire_pos().distance_to(pin_2.get_wire_pos())
	segment_length = max_length / (num_segments - 1)
	
	wire.clear_points()
	for i in range(num_segments):
		var start_pos = pin_1.get_wire_pos().lerp(pin_2.get_wire_pos(), float(i) / (num_segments - 1))
		pos_current.append(start_pos)
		pos_old.append(start_pos)
		wire.add_point(to_local(start_pos))
	
	pin_1.pin_canceled.connect(_on_pin_canceled)
	pin_2.pin_canceled.connect(_on_pin_canceled)
	update_wire_thickness()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pin_1.is_dragging:
		pin_1.global_position = get_global_mouse_position()
	elif pin_2.is_dragging:
		pin_2.global_position = get_global_mouse_position()
	_apply_leash()
	_simulate_rope(delta)


func _on_pin_canceled():
	pin_1.disconnect_from_port()
	pin_2.disconnect_from_port()
	pin_1.is_returning = true
	pin_2.is_returning = true
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(pin_1, "global_position", pin_1.home_position, 0.3)
	tween.tween_property(pin_2, "global_position", pin_2.home_position, 0.3)
	tween.chain().tween_callback(_on_return_finished)


func _simulate_rope(delta: float):
	var floor_y = pin_1.home_position.y
	
	for i in range(num_segments):
		var velocity = (pos_current[i] - pos_old[i]) * damping
		pos_old[i] = pos_current[i]
		pos_current[i] += velocity + (gravity * delta * delta)
		
		if pos_current[i].y > floor_y:
			pos_current[i].y = floor_y
	
	for _iteration in range(stiffness):
		for i in range(num_segments - 1):
			var center = (pos_current[i] + pos_current[i+1]) / 2.0
			var direction = (pos_current[i] - pos_current[i+1]).normalized()
			var offset = direction * (segment_length / 2.0)
			pos_current[i] = center + offset
			pos_current[i+1] = center - offset
		if pin_1.is_dragging or pin_1.connected_port != null or pin_1.is_returning:
			pos_current[0] = pin_1.get_wire_pos()
		if pin_2.is_dragging or pin_2.connected_port != null or pin_2.is_returning:
			pos_current[num_segments - 1] = pin_2.get_wire_pos()
	
	if not pin_1.is_dragging and pin_1.connected_port == null and not pin_1.is_returning:
		pin_1.global_position = pos_current[0] - pin_1.get_wire_offset()
	if not pin_2.is_dragging and pin_2.connected_port == null and not pin_2.is_returning:
		pin_2.global_position = pos_current[num_segments - 1] - pin_2.get_wire_offset()
	
	for i in range(num_segments):
		wire.set_point_position(i, to_local(pos_current[i]))


func _on_return_finished():
	pin_1.is_returning = false
	pin_2.is_returning = false


func _apply_leash() -> void:
	var p1_anchor = pin_1.get_wire_pos()
	var p2_anchor = pin_2.get_wire_pos()
	var current_dist = p1_anchor.distance_to(p2_anchor)
	
	if current_dist > max_length:
		if pin_1.is_dragging:
			if pin_2.connected_port != null:
				var dir = p2_anchor.direction_to(p1_anchor)
				var target_anchor_pos = p2_anchor + (dir * max_length)
				pin_1.global_position = target_anchor_pos - pin_1.get_wire_offset()
			else:
				var dir = p1_anchor.direction_to(p2_anchor)
				var target_anchor_pos = p1_anchor + (dir * max_length)
				pin_2.global_position = target_anchor_pos - pin_2.get_wire_offset()
		elif pin_2.is_dragging:
			if pin_1.connected_port != null:
				var dir = p1_anchor.direction_to(p2_anchor)
				var target_anchor_pos = p1_anchor + (dir * max_length)
				pin_2.global_position = target_anchor_pos - pin_2.get_wire_offset()
			else:
				var dir = p2_anchor.direction_to(p1_anchor)
				var target_anchor_pos = p2_anchor + (dir * max_length)
				pin_1.global_position = target_anchor_pos - pin_1.get_wire_offset()


func get_other_pin(entry_pin: Area2D):
	if entry_pin == pin_1:
		return pin_2
	elif entry_pin == pin_2:
		return pin_1
	
	return null


func update_wire_thickness():
	if pin_1 == null or pin_2 == null:
		return
	
	var is_p1_connected = pin_1.connected_port != null
	var is_p2_connected = pin_2.connected_port != null
	var ratio = wire_width_base / wire_width_connected
	
	if funnel_curve == null:
		funnel_curve = Curve.new()
		wire.width_curve = funnel_curve
		wire.width = wire_width_connected
	
	funnel_curve.clear_points()
	
	var l_ratio = funnel_lenght_ratio
	var r_ratio = 1.0 - funnel_lenght_ratio
	
	if not is_p1_connected and not is_p2_connected:
		funnel_curve.add_point(Vector2(0.0, ratio), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
		funnel_curve.add_point(Vector2(1.0, ratio), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
	elif is_p1_connected and not is_p2_connected:
		funnel_curve.add_point(Vector2(0.0, 1.0), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
		funnel_curve.add_point(Vector2(l_ratio, ratio), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
		funnel_curve.add_point(Vector2(1.0, ratio), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
	elif not is_p1_connected and is_p2_connected:
		funnel_curve.add_point(Vector2(0.0, ratio), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
		funnel_curve.add_point(Vector2(r_ratio, ratio), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR) 
		funnel_curve.add_point(Vector2(1.0, 1.0), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
	else:
		funnel_curve.add_point(Vector2(0.0, 1.0), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR) 
		funnel_curve.add_point(Vector2(l_ratio, ratio), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
		funnel_curve.add_point(Vector2(r_ratio, ratio), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR) 
		funnel_curve.add_point(Vector2(1.0, 1.0), 0, 0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
