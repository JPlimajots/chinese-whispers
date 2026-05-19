extends Node

signal circuit_completed(origin_id: String, destination_id: String)


func evaluate_new_connection(trigger_port: Area2D) -> void:
	var origin_port = _get_opposite_end(trigger_port)
	
	if origin_port == null:
		return
		
	_trace_from_origin(origin_port)


func _get_opposite_end(starting_port: Area2D) -> Area2D:
	var current_port = starting_port
	var visited = []
	
	while current_port != null:
		if current_port in visited:
			return null 
			
		visited.append(current_port)
		var pin = current_port.connected_pin
		if pin == null: return null
			
		var cable = pin.get_parent()
		var other_pin = cable.get_other_pin(pin)
		var next_port = other_pin.connected_port
		if next_port == null: return null
		
		if next_port.grid_pos.begins_with("ADAPT"):
			var adapter = next_port.get_parent()
			current_port = adapter.get_linked_port(next_port)
		else:
			return next_port
			
	return null


func _trace_from_origin(origin_port: Area2D) -> void:
	var current_port = origin_port
	var visited = []
	var path_log = []
	
	path_log.append("Origem: " + current_port.get_full_id())
	
	while current_port != null:
		if current_port in visited: return
		visited.append(current_port)
		
		var pin = current_port.connected_pin
		if pin == null: return
			
		var cable = pin.get_parent()
		var other_pin = cable.get_other_pin(pin)
		var next_port = other_pin.connected_port
		if next_port == null: return
			
		path_log.append(" -> Cabo(" + cable.cable_color + ") -> Para: " + next_port.get_full_id())
		
		if next_port.grid_pos.begins_with("ADAPT"):
			var adapter = next_port.get_parent()
			var linked_port = adapter.get_linked_port(next_port)
			path_log.append(" [Ponte Interna] -> " + linked_port.get_full_id())
			
			current_port = linked_port 
		else:
			
			print("Circuito Fechado! Caminho completo: ", path_log)
			circuit_completed.emit(origin_port.get_full_id(), next_port.get_full_id())
			return
