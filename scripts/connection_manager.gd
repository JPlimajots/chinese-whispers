extends Node

signal connection_success(caller_name: String, target_name: String)
signal connection_chaos(caller_name: String, wrong_target_name: String, origin_id: String, target_id: String) 
signal connection_dropped(caller_name: String, reason: String)

var current_call_id: String = "01_seed"

const DIRECTORY: Dictionary = {
	"A1_red": "Hospital",
	"A1_green": "Pincer's Family House",
	"A2_red": "Big Corp",
	"A2_green": "Johnson's Family House",
	"A3_red": "Miller's Family House",
	"A3_green": "Docks",
	"A4_red": "Mafia",
	"A4_green": "Zoo",
	"A5_red": "Mayor Pincer's Office",
	"A5_green": "Boss's Office",
	
	"B1_red": "Firefighters",
	"B1_green": "Police Precinct",
	"B2_red": "School",
	"B2_green": "Church",
	"B3_red": "Thompson's Family House",
	"B3_green": "Silva's Family House",
	"B4_red": "Brothel",
	"B4_green": "Bakery",
	"B5_red": "News",
	"B5_green": "Restaurant"
}

# Exemplo provisório
var active_gabarito: Dictionary = {
	"A1_green": "B5_green",
	"A1_red": "B1_red"
}

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
	
	var origin_id = current_port.get_full_id()
	path_log.append("Origem: " + origin_id)
	
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
			_validate_connection(origin_port, next_port, path_log)
			return


func _validate_connection(origin_port: Area2D, destination_port: Area2D, path: Array) -> void:
	var origin_id = origin_port.get_full_id()
	var destination_id = destination_port.get_full_id()
	var caller_name = DIRECTORY.get(origin_id, origin_id)
	var target_name = DIRECTORY.get(destination_id, destination_id)
	var first_cable = origin_port.connected_pin.get_parent()
	var last_cable = destination_port.connected_pin.get_parent()
	
	if first_cable.cable_color != origin_port.current_light and origin_port.current_light != "none":
		print("\n📵 LIGAÇÃO CAIU! O cabo [", first_cable.cable_color, "] não serve para a chamada [", origin_port.current_light, "].")
		print("Tentativa: ", path)
		connection_dropped.emit(caller_name, "Cabo incompatível na origem")
		return
	
	if active_gabarito.has(origin_id):
		var expected_destination = active_gabarito[origin_id]
		
		if destination_id == expected_destination and last_cable.cable_color == destination_port.current_light:
			print("\n🟢 CONEXÃO ESTABELECIDA COM SUCESSO!")
			print("Caminho físico: ", path)
			print(caller_name, " está conversando com ", target_name, ".")
			connection_success.emit(caller_name, target_name)
		else:
			print("\n🔴 INSTABILIDADE NA LINHA! INSTALAÇÃO DO CAOS!")
			print("Caminho físico: ", path)
			if destination_id == expected_destination:
				print("Causa do Caos: Destino correto (", target_name, "), mas o cabo usado na chegada foi [", last_cable.cable_color, "] em vez de [", destination_port.current_light, "]!")
			else:
				print("Causa do Caos: Era para ", caller_name, " falar com ", DIRECTORY.get(expected_destination), ", mas caiu no(a) ", target_name, "!")
			connection_chaos.emit(caller_name, target_name, origin_id, destination_id)
	else:
		print("\n⚪ Linha fantasma: Conexão feita entre ", caller_name, " e ", target_name, ", mas ninguém ligou.")
		
