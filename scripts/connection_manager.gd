extends Node

signal connection_success(caller_name: String, target_name: String)
signal connection_chaos(caller_name: String, wrong_target_name: String, origin_id: String, target_id: String) 
signal connection_dropped(caller_name: String, reason: String)
signal new_call_started(call_id: String)
signal player_confirmed
signal typing_finished
signal clear_ui_text
signal caller_lost_patience(text: String, caller_name: String)

var current_call_id: String = ""
var is_typing: bool = false
var max_patience: float = 60.0
var current_patience: float = 60.0
var is_patience_ticking: bool = false
var penalty_time: float = 15.0
var is_ringing: bool = false
var was_answered: bool = false
var lost_calls_count: int = 0
var max_allowed_lost_calls: int = 3
var call_resolved: bool = false

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


func _ready() -> void:
	NarrativeManager.reset_call_pool()


func start_first_call() -> void:
	spawn_next_call()


func _process(delta: float) -> void:
	if is_patience_ticking:
		current_patience -= delta
		if current_patience <= 0:
			_trigger_hangup()


func evaluate_new_connection(trigger_port: Area2D) -> void:
	if call_resolved:
		return
	
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
	var call_data: Dictionary = NarrativeManager.NARRATIVES.get(current_call_id, {})
	
	if call_data.is_empty():
		print("\n⚪ Linha fantasma: Conexão feita, mas não há chamada na linha.")
		return
		
	var origin_grid = origin_port.get_full_id() 
	var destination_grid = destination_port.get_full_id() 
	var first_cable = origin_port.connected_pin.get_parent()
	var last_cable = destination_port.connected_pin.get_parent()
	var caller_id: String = call_data["caller_id"] # Ex: "A1_red"
	var expected_origin_grid = caller_id.split("_")[0] # Ex: "A1"
	var expected_origin_color = caller_id.split("_")[1] # Ex: "red"
	var caller_name = DIRECTORY.get(caller_id, caller_id)
	
	if origin_grid != expected_origin_grid:
		print("\n⚪ Linha cruzada: A origem plugada (", origin_grid, ") não é quem está chamando (", expected_origin_grid, ").")
		connection_dropped.emit(caller_name, "Origem incorreta")
		return
		
	if first_cable.cable_color != expected_origin_color:
		print("\n📵 LIGAÇÃO CAIU! O cabo [", first_cable.cable_color, "] não serve para a chamada [", expected_origin_color, "].")
		connection_dropped.emit(caller_name, "Cabo incompatível na origem")
		return
		
	var correct_id: String = call_data["correct_target"] # Ex: "B1_red"
	var correct_grid = correct_id.split("_")[0]
	var correct_color = correct_id.split("_")[1]
	var correct_name = DIRECTORY.get(correct_id, correct_id)
	
	if destination_grid == correct_grid:
		if last_cable.cable_color == correct_color:
			if call_resolved: return
			call_resolved = true
			is_patience_ticking = false
			print("\n🟢 CONEXÃO ESTABELECIDA COM SUCESSO!")
			print("Caminho físico: ", path)
			connection_success.emit(caller_name, correct_name)
			var origin_node = _get_port_by_id(caller_id)
			if origin_node: origin_node.set_led_solid(expected_origin_color)
			var dest_node = _get_port_by_id(correct_id)
			if dest_node: dest_node.set_led_solid(correct_color)
			for w_id in call_data.get("wrong_targets", {}).keys():
				var w_port = _get_port_by_id(w_id)
				if w_port: w_port.set_led_idle()
			await get_tree().create_timer(2.0).timeout
			_advance_narrative(call_data.get("next_trigger_success"))
		else:
			print("\n📵 LIGAÇÃO CAIU! Destino certo, mas cor do pino errada no final.")
			connection_dropped.emit(caller_name, "Cabo incompatível no destino")
		return
		
	for wrong_id in call_data.get("wrong_targets", {}).keys():
		var wrong_grid = wrong_id.split("_")[0]
		if destination_grid == wrong_grid:
			if call_resolved: return
			call_resolved = true
			is_patience_ticking = false
			var chaos_data = call_data["wrong_targets"][wrong_id]
			var wrong_name = DIRECTORY.get(wrong_id, wrong_id)
			print("\n🔴 INSTABILIDADE NA LINHA! INSTALAÇÃO DO CAOS!")
			print("Caminho físico: ", path)
			var origin_node = _get_port_by_id(caller_id)
			if origin_node: origin_node.set_led_solid(expected_origin_color)
			var dest_node = _get_port_by_id(wrong_id)
			if dest_node: dest_node.set_led_solid(wrong_id.split("_")[1])
			var c_port = _get_port_by_id(correct_id)
			if c_port: c_port.set_led_idle()
			for other_w_id in call_data.get("wrong_targets", {}).keys():
				if other_w_id != wrong_id:
					var w_port = _get_port_by_id(other_w_id)
					if w_port: w_port.set_led_idle()
			await get_tree().create_timer(2.0).timeout
			connection_chaos.emit(caller_name, wrong_name, caller_id, wrong_id)
			_advance_narrative(chaos_data.get("next_trigger"))
			return
			
	print("\n⚪ Linha cruzada: O jogador plugou em um lugar irrelevante para essa chamada.")
	current_patience -= penalty_time
	if current_patience > 0:
		print(">> Punição de tempo! Paciência caiu para: ", int(current_patience), "s")
	else:
		_trigger_hangup()
	connection_dropped.emit(caller_name, "Destino não mapeado na narrativa atual")
	

func spawn_next_call():
	if NarrativeManager.available_calls.is_empty():
		print(">> O expediente acabou! Nenhuma chamada restante na linha.")
		current_call_id = ""
		return
	
	call_resolved = false
	
	var random_call = NarrativeManager.available_calls.pick_random()
	
	NarrativeManager.available_calls.erase(random_call)
	current_call_id = random_call
	print(">> O telefone toca! Nova chamada recebida: ", current_call_id)
	var call_data = NarrativeManager.NARRATIVES[random_call]
	var caller_id: String = call_data["caller_id"]
	var caller_color: String = caller_id.split("_")[1]
	var caller_port = _get_port_by_id(caller_id)
	
	if caller_port:
		caller_port.set_led_blinking(caller_color, 0.1)
		current_patience = max_patience
		is_patience_ticking = true
		is_ringing = true
		was_answered = false
		while is_ringing and current_patience > 0:
			await get_tree().process_frame
		if current_patience <= 0:
			print("[DEBUG] Corrotina antiga abortada com segurança (Tempo Esgotou).")
			return
		was_answered = true
		is_patience_ticking = false
		caller_port.set_led_solid(caller_color)
		await get_tree().create_timer(1.5).timeout
		
		new_call_started.emit(current_call_id)
		
		await typing_finished
		await get_tree().create_timer(1.5).timeout
		
		var correct_id: String = call_data["correct_target"]
		var correct_color: String = correct_id.split("_")[1]
		var correct_port = _get_port_by_id(correct_id)
		is_patience_ticking = true
		
		if correct_port:
			correct_port.set_led_blinking(correct_color, 0.5)
			
		for wrong_id in call_data.get("wrong_targets", {}).keys():
			var wrong_color: String = wrong_id.split("_")[1]
			var wrong_port = _get_port_by_id(wrong_id)
			if wrong_id:
				wrong_port.set_led_blinking(wrong_color, 0.5)


func _advance_narrative(next_id):
	if next_id != null:
		current_call_id = next_id
		print(">> Próxima chamada engatilahda: ", current_call_id)
		new_call_started.emit(current_call_id)
	else:
		print(">> [DEBUG] Fim do atendimento. Aguardando texto terminar de ser digitado!")
		if is_typing:
			await typing_finished
		print(">> [DEBUG] Texto 100% visível na tela! Aguardando o jogador apertar ENTER para proseguir...")
		await player_confirmed
		print(">> [DEBUG] Confirmação recebida! Limpando a interface...")
		clear_ui_text.emit()
		_clear_current_call_visuals(current_call_id)
		await get_tree().create_timer(5.0).timeout
		print(">> [DEBUG] Cooldown de silêncio finalizado. Sorteando o próximo caso...")
		spawn_next_call()


func _get_port_by_id(target_id: String):
	var parts = target_id.split("_")
	var target_grid = parts[0]
	var all_ports = get_tree().get_nodes_in_group("panel_ports")
	
	for port in all_ports:
		if port.grid_pos == target_grid:
			return port
	
	print("⚠️ AVISO: Porta física não encontrada para o ID -> ", target_id)
	return null


func _clear_current_call_visuals(call_id: String):
	var call_data = NarrativeManager.NARRATIVES.get(call_id, {})
	if call_data.is_empty(): return
	
	var caller_port = _get_port_by_id(call_data["caller_id"])
	if caller_port: caller_port.set_led_idle()
	
	var correct_port = _get_port_by_id(call_data["correct_target"])
	if correct_port: correct_port.set_led_idle()
	
	for wrong_id in call_data.get("wrong_targets", {}).keys():
		var wrong_port = _get_port_by_id(wrong_id)
		if wrong_port: wrong_port.set_led_idle()
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact_confirm"):
		if is_ringing:
			is_ringing = false
			print(">> [DEBUG] Chamada atendida pelo jogador!")
		else:
			player_confirmed.emit()
			print(">> [DEBUG] Tecla ESPAÇO detectada. Sinal player_confirmed disparado!")


func _trigger_hangup():
	if call_resolved:
		return
	call_resolved = true
	is_patience_ticking = false
	is_ringing = false
	current_patience = 0
	
	var call_data = NarrativeManager.NARRATIVES.get(current_call_id, {})
	var caller_id = call_data.get("caller_id", "")
	var caller_name = NarrativeManager.PORT_DIRECTORY.get(caller_id, {}).get("default_character", "")
	
	lost_calls_count += 1
	print(">> [AVISO DO RH] Advertência registrada: ", lost_calls_count, "/", max_allowed_lost_calls)
	
	if not was_answered:
		print("[DEBUG] Chamada perdida antes de atender. Avançando sem pedir confirmação... ")
		connection_dropped.emit(caller_name, "Desligou por impaciência")
		_clear_current_call_visuals(current_call_id)
		ConnectionManager.is_typing = false
		clear_ui_text.emit()
		
		if lost_calls_count > max_allowed_lost_calls:
			_trigger_game_over()
			return
		
		await get_tree().create_timer(5.0).timeout
		spawn_next_call()
	else:
		print(">> [DEBUG] Paciência esgotou durante a ligação. Cliente sendo rude!")
		var rude_text = call_data.get("timeout_text")
		caller_lost_patience.emit(rude_text, caller_name)
		await typing_finished
		await player_confirmed
		connection_dropped.emit(caller_name, "Desligou após ofender o operador")
		_clear_current_call_visuals(current_call_id)
		clear_ui_text.emit()
		
		if lost_calls_count > max_allowed_lost_calls:
			_trigger_game_over()
			return
		
		await get_tree().create_timer(3.0).timeout
		spawn_next_call()


func _trigger_game_over():
	print("\n=======================================================")
	print("                   GAME OVER")
	print(" VOCÊ FOI DEMITIDO POR INCOMPETÊNCIA NO ATENDIMENTO!")
	print("=======================================================\n")
