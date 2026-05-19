extends Node2D

@onready var wire: Line2D = $Wire
@onready var pin_1: Area2D = $Pin1
@onready var pin_2: Area2D = $Pin2

@export var num_segments: int = 9
@export var stiffness: int = 30 
@export var gravity_y: float = 2800.0
@export var damping: float = 0.94 

@export_enum("red", "green") var cable_color: String = "red":
	set(value):
		cable_color = value
		_update_cable_visuals()

var max_length: float = 0.0
var gravity: Vector2 = Vector2.ZERO
var segment_length: float = 0.0
var pos_current: Array[Vector2] = []
var pos_old: Array[Vector2] = []


func _ready() -> void:
	gravity = Vector2(0, gravity_y)
	max_length = pin_1.global_position.distance_to(pin_2.global_position)
	segment_length = max_length / (num_segments - 1)
	
	wire.clear_points()
	for i in range(num_segments):
		var start_pos = pin_1.global_position.lerp(pin_2.global_position, float(i) / (num_segments - 1))
		pos_current.append(start_pos)
		pos_old.append(start_pos)
		wire.add_point(to_local(start_pos))
	
	pin_1.pin_canceled.connect(_on_pin_canceled)
	pin_2.pin_canceled.connect(_on_pin_canceled)
	
	_update_cable_visuals()


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
			pos_current[i].x = pos_old[i].x
	
	for _iteration in range(stiffness):
		for i in range(num_segments - 1):
			var center = (pos_current[i] + pos_current[i+1]) / 2.0
			var direction = (pos_current[i] - pos_current[i+1]).normalized()
			var offset = direction * (segment_length / 2.0)
			pos_current[i] = center + offset
			pos_current[i+1] = center - offset
		if pin_1.is_dragging or pin_1.connected_port != null or pin_1.is_returning:
			pos_current[0] = pin_1.global_position
		if pin_2.is_dragging or pin_2.connected_port != null or pin_2.is_returning:
			pos_current[num_segments - 1] = pin_2.global_position
	
	if not pin_1.is_dragging and pin_1.connected_port == null and not pin_1.is_returning:
		pin_1.global_position = pos_current[0]
	if not pin_2.is_dragging and pin_2.connected_port == null and not pin_2.is_returning:
		pin_2.global_position = pos_current[num_segments - 1]
	
	for i in range(num_segments):
		wire.set_point_position(i, to_local(pos_current[i]))


func _on_return_finished():
	pin_1.is_returning = false
	pin_2.is_returning = false


func _apply_leash() -> void:
	var current_dist = pin_1.global_position.distance_to(pin_2.global_position)
	
	if current_dist > max_length:
		if pin_1.is_dragging:
			if pin_2.connected_port != null:
				var dir = pin_2.global_position.direction_to(pin_1.global_position)
				pin_1.global_position = pin_2.global_position + (dir * max_length)
			else:
				var dir = pin_1.global_position.direction_to(pin_2.global_position)
				pin_2.global_position = pin_1.global_position + (dir * max_length)
		elif pin_2.is_dragging:
			if pin_1.connected_port != null:
				var dir = pin_1.global_position.direction_to(pin_2.global_position)
				pin_2.global_position = pin_1.global_position + (dir * max_length)
			else:
				var dir = pin_2.global_position.direction_to(pin_1.global_position)
				pin_1.global_position = pin_2.global_position + (dir * max_length)


func _update_cable_visuals():
	if not is_inside_tree() or not wire:
		return
	
	if cable_color == "red":
		wire.default_color = Color("#b62222")
	elif cable_color == "green":
		wire.default_color = Color("#228b45")


func get_other_pin(entry_pin: Area2D):
	if entry_pin == pin_1:
		return pin_2
	elif entry_pin == pin_2:
		return pin_1
	
	return null
