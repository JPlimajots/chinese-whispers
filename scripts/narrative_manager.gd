extends Node


const NARRATIVES: Dictionary = {
	"01_seed": {
		"caller_id": "CALLER_SEED_1",
		"initial_text": "HOOK_TAG_1",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_1",
		"success_text": "SUCCESS_REPLY_1A",
		 "next_trigger_success": null,
		
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_1B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_1": {
				"chaos_text": "CHAOS_REPLY_1C",
				"next_target": null
			}
		}
	},
	
	"02_seed": {
		"caller_id": "CALLER_SEED_2",
		"initial_text": "HOOK_TAG_2",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_2",
		"success_text": "SUCCESS_REPLY_2A",
		 "next_trigger_success": null,
		
		"wrong_targets": {
			"WRONG_TARGET_B_2": {
				"chaos_text": "CHAOS_REPLY_2B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_2": {
				"chaos_text": "CHAOS_REPLY_2C",
				"next_target": null
			}
		}
	},
	
	"03_seed": {
		"caller_id": "CALLER_SEED_3",
		"initial_text": "HOOK_TAG_3",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_3",
		"success_text": "SUCCESS_REPLY_3A",
		 "next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_3": {
				"chaos_text": "CHAOS_REPLY_3B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_3": {
				"chaos_text": "CHAOS_REPLY_3C",
				"next_target": null
			}
		}
	},
	
	"04_seed": {
		"caller_id": "CALLER_SEED_4",
		"initial_text": "HOOK_TAG_4",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_4",
		"success_text": "SUCCESS_REPLY_4A",
		 "next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_4": {
				"chaos_text": "CHAOS_REPLY_4B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_4": {
				"chaos_text": "CHAOS_REPLY_4C",
				"next_target": null
			}
		}
	},
	
	"05_seed": {
		"caller_id": "CALLER_SEED_5",
		"initial_text": "HOOK_TAG_5",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_5",
		"success_text": "SUCCESS_REPLY_5A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_5": {
				"chaos_text": "CHAOS_REPLY_5B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_5": {
				"chaos_text": "CHAOS_REPLY_5C",
				"next_target": null
			}
		}
	},
	
	"06_seed": {
		"caller_id": "CALLER_SEED_6",
		"initial_text": "HOOK_TAG_6",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_6",
		"success_text": "SUCCESS_REPLY_6A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_6": {
				"chaos_text": "CHAOS_REPLY_6B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_6": {
				"chaos_text": "CHAOS_REPLY_6C",
				"next_target": null
			}
		}
	},
	
	"07_seed": {
		"caller_id": "CALLER_SEED_7",
		"initial_text": "HOOK_TAG_7",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_7",
		"success_text": "SUCCESS_REPLY_7A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_7": {
				"chaos_text": "CHAOS_REPLY_7B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_7": {
				"chaos_text": "CHAOS_REPLY_7C",
				"next_target": null
			}
		}
	},
	
	"08_seed": {
		"caller_id": "CALLER_SEED_8",
		"initial_text": "HOOK_TAG_8",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_8",
		"success_text": "SUCCESS_REPLY_8A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_8": {
				"chaos_text": "CHAOS_REPLY_8B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_8": {
				"chaos_text": "CHAOS_REPLY_8C",
				"next_target": null
			}
		}
	},
	
	"09_seed": {
		"caller_id": "CALLER_SEED_9",
		"initial_text": "HOOK_TAG_9",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_9",
		"success_text": "SUCCESS_REPLY_9A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_9": {
				"chaos_text": "CHAOS_REPLY_9B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_9": {
				"chaos_text": "CHAOS_REPLY_9C",
				"next_target": null
			}
		}
	},
	
	"10_seed": {
		"caller_id": "CALLER_SEED_10",
		"initial_text": "HOOK_TAG_10",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_10",
		"success_text": "SUCCESS_REPLY_10A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_10": {
				"chaos_text": "CHAOS_REPLY_10B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_10": {
				"chaos_text": "CHAOS_REPLY_10C",
				"next_target": null
			}
		}
	},
	
	"11_seed": {
		"caller_id": "CALLER_SEED_11",
		"initial_text": "HOOK_TAG_11",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_11",
		"success_text": "SUCCESS_REPLY_11A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_11": {
				"chaos_text": "CHAOS_REPLY_11B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_11": {
				"chaos_text": "CHAOS_REPLY_11C",
				"next_target": null
			}
		}
	},
	
	"12_seed": {
		"caller_id": "CALLER_SEED_12",
		"initial_text": "HOOK_TAG_12",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_12",
		"success_text": "SUCCESS_REPLY_12A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_12": {
				"chaos_text": "CHAOS_REPLY_12B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_12": {
				"chaos_text": "CHAOS_REPLY_12C",
				"next_target": null
			}
		}
	},
	
	"13_seed": {
		"caller_id": "CALLER_SEED_13",
		"initial_text": "HOOK_TAG_13",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_13",
		"success_text": "SUCCESS_REPLY_13A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_13": {
				"chaos_text": "CHAOS_REPLY_13B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_13": {
				"chaos_text": "CHAOS_REPLY_13C",
				"next_target": null
			}
		}
	},
	
		"14_seed": {
		"caller_id": "CALLER_SEED_14",
		"initial_text": "HOOK_TAG_14",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_14",
		"success_text": "SUCCESS_REPLY_14A",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_14": {
				"chaos_text": "CHAOS_REPLY_14B",
				"next_trigger": null
			},
			"WRONG_TARGET_C_14": {
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
