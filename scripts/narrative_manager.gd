extends Node


const NARRATIVES: Dictionary = {
	"01_seed": {
		"caller_id": "A1_red",
		"initial_text": "HOOK_TAG_1",
		# Caminho principal (sucesso)
		"correct_target": "B1_red",
		"success_text": "SUCCESS_REPLY_1A",
		 "next_trigger_success": null,
		
		"wrong_targets": {
			"A4_red": {
				"chaos_text": "CHAOS_REPLY_1B",
				"next_trigger": null
			},
			"B5_green": {
				"chaos_text": "CHAOS_REPLY_1C",
				"next_target": null
			}
		}
	},
	
	"02_seed": {
		"caller_id": "B2_green",
		"initial_text": "HOOK_TAG_2",
		# Caminho principal (sucesso)
		"correct_target": "B3_green",
		"success_text": "SUCCESS_REPLY_2A",
		 "next_trigger_success": null,
		
		"wrong_targets": {
			"A2_green": {
				"chaos_text": "CHAOS_REPLY_2B",
				"next_trigger": null
			},
			"B4_red": {
				"chaos_text": "CHAOS_REPLY_2C",
				"next_target": null
			}
		}
	},
	
	"03_seed": {
		"caller_id": "A3_green",
		"initial_text": "HOOK_TAG_3",
		# Caminho principal (sucesso)
		"correct_target": "B2_red",
		"success_text": "SUCCESS_REPLY_3A",
		 "next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A4_red": {
				"chaos_text": "CHAOS_REPLY_3B",
				"next_trigger": null
			},
			"B5_green": {
				"chaos_text": "CHAOS_REPLY_3C",
				"next_target": null
			}
		}
	},
	
	"04_seed": {
		"caller_id": "A1_green",
		"initial_text": "HOOK_TAG_4",
		# Caminho principal (sucesso)
		"correct_target": "B1_green",
		"success_text": "SUCCESS_REPLY_4A",
		 "next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A2_red": {
				"chaos_text": "CHAOS_REPLY_4B",
				"next_trigger": null
			},
			"B4_red": {
				"chaos_text": "CHAOS_REPLY_4C",
				"next_target": null
			}
		}
	},
	
	"05_seed": {
		"caller_id": "B3_red",
		"initial_text": "HOOK_TAG_5",
		# Caminho principal (sucesso)
		"correct_target": "A5_green",
		"success_text": "SUCCESS_REPLY_5A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B2_green": {
				"chaos_text": "CHAOS_REPLY_5B",
				"next_trigger": null
			},
			"A1_red": {
				"chaos_text": "CHAOS_REPLY_5C",
				"next_target": null
			}
		}
	},
	
	"06_seed": {
		"caller_id": "A2_green",
		"initial_text": "HOOK_TAG_6",
		# Caminho principal (sucesso)
		"correct_target": "B4_green",
		"success_text": "SUCCESS_REPLY_6A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A3_red": {
				"chaos_text": "CHAOS_REPLY_6B",
				"next_trigger": null
			},
			"B1_red": {
				"chaos_text": "CHAOS_REPLY_6C",
				"next_target": null
			}
		}
	},
	
	"07_seed": {
		"caller_id": "B5_red",
		"initial_text": "HOOK_TAG_7",
		# Caminho principal (sucesso)
		"correct_target": "A4_green",
		"success_text": "SUCCESS_REPLY_7A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B3_green": {
				"chaos_text": "CHAOS_REPLY_7B",
				"next_trigger": null
			},
			"A2_red": {
				"chaos_text": "CHAOS_REPLY_7C",
				"next_target": null
			}
		}
	},
	
	"08_seed": {
		"caller_id": "A5_red",
		"initial_text": "HOOK_TAG_8",
		# Caminho principal (sucesso)
		"correct_target": "B2_green",
		"success_text": "SUCCESS_REPLY_8A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A1_green": {
				"chaos_text": "CHAOS_REPLY_8B",
				"next_trigger": null
			},
			"B4_red": {
				"chaos_text": "CHAOS_REPLY_8C",
				"next_target": null
			}
		}
	},
	
	"09_seed": {
		"caller_id": "B1_red",
		"initial_text": "HOOK_TAG_9",
		# Caminho principal (sucesso)
		"correct_target": "A3_green",
		"success_text": "SUCCESS_REPLY_9A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B5_green": {
				"chaos_text": "CHAOS_REPLY_9B",
				"next_trigger": null
			},
			"A4_red": {
				"chaos_text": "CHAOS_REPLY_9C",
				"next_target": null
			}
		}
	},
	
	"10_seed": {
		"caller_id": "A4_green",
		"initial_text": "HOOK_TAG_10",
		# Caminho principal (sucesso)
		"correct_target": "B3_red",
		"success_text": "SUCCESS_REPLY_10A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A2_green": {
				"chaos_text": "CHAOS_REPLY_10B",
				"next_trigger": null
			},
			"B1_green": {
				"chaos_text": "CHAOS_REPLY_10C",
				"next_target": null
			}
		}
	},
	
	"11_seed": {
		"caller_id": "B2_red",
		"initial_text": "HOOK_TAG_11",
		# Caminho principal (sucesso)
		"correct_target": "A1_red",
		"success_text": "SUCCESS_REPLY_11A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B4_green": {
				"chaos_text": "CHAOS_REPLY_11B",
				"next_trigger": null
			},
			"A5_green": {
				"chaos_text": "CHAOS_REPLY_11C",
				"next_target": null
			}
		}
	},
	
	"12_seed": {
		"caller_id": "A3_red",
		"initial_text": "HOOK_TAG_12",
		# Caminho principal (sucesso)
		"correct_target": "B5_red",
		"success_text": "SUCCESS_REPLY_12A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A2_red": {
				"chaos_text": "CHAOS_REPLY_12B",
				"next_trigger": null
			},
			"B3_green": {
				"chaos_text": "CHAOS_REPLY_12C",
				"next_target": null
			}
		}
	},
	
	"13_seed": {
		"caller_id": "B4_red",
		"initial_text": "HOOK_TAG_13",
		# Caminho principal (sucesso)
		"correct_target": "A5_red",
		"success_text": "SUCCESS_REPLY_13A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B1_red": {
				"chaos_text": "CHAOS_REPLY_13B",
				"next_trigger": null
			},
			"A1_green": {
				"chaos_text": "CHAOS_REPLY_13C",
				"next_target": null
			}
		}
	},
	
	"14_seed": {
		"caller_id": "A2_red",
		"initial_text": "HOOK_TAG_14",
		# Caminho principal (sucesso)
		"correct_target": "B2_green",
		"success_text": "SUCCESS_REPLY_14A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A4_green": {
				"chaos_text": "CHAOS_REPLY_14B",
				"next_trigger": null
			},
			"B5_red": {
				"chaos_text": "CHAOS_REPLY_14C",
				"next_target": null
			}
		}
	},
}

var available_calls: Array[String] = []

func reset_call_pool():
	available_calls.clear()
	for call_id in NARRATIVES.keys():
		available_calls.append(call_id)
