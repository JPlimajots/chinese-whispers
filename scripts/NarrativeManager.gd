extends Node


const NARRATIVES: Dictionary = {
	"01_seed": {
		"caller_id": "CALLER_SEED_1",
		"initial_text": "HOOK_TAG_1",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_1",
		"success_text": "SUCCESS_REPLY_1A",
		 "next_trigger_success": "01_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_1B",
				"next_trigger": "01_exp_b"
			},
			"WRONG_TARGET_C_1": {
				"chaos_text": "CHAOS_REPLY_1C",
				"next_target": "01_exp_c"
			}
		}
	},
	# --- EXPANSION 1A (Desdobramento do Sucesso) ---
	"01_exp_a": {
		"caller_id": "CALLER_EXP_1A",
		"initial_text": "HOOK_EXP_1A",
		
		"correct_target": "SUCCESS_TARGET_1A",
		"success_text": "CONCLUSION_1A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null, 
		
		"wrong_targets": {
			"ERROR_TARGET_1A_2": {
				"chaos_text": "CONCLUSION_1A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_1A_3": {
				"chaos_text": "CONCLUSION_1A_3",
				"next_trigger": null
			}
		}
	},
	
	# --- EXPANSION 1B (Desdobramento do Caos 1) ---
	"01_exp_b": {
		"caller_id": "CALLER_EXP_1B",
		"initial_text": "HOOK_EXP_1B",
		
		"correct_target": "SUCCESS_TARGET_1B",
		"success_text": "CONCLUSION_1B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_1B_2": {
				"chaos_text": "CONCLUSION_1B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_1B_3": {
				"chaos_text": "CONCLUSION_1B_3",
				"next_trigger": null
			}
		}
	},
	
	# --- EXPANSION 1C (Desdobramento do Caos 2) ---
	"01_exp_c": {
		"caller_id": "CALLER_EXP_1C",
		"initial_text": "HOOK_EXP_1C",
		
		"correct_target": "SUCCESS_TARGET_1C",
		"success_text": "CONCLUSION_1C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_1C_2": {
				"chaos_text": "CONCLUSION_1C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_1C_3": {
				"chaos_text": "CONCLUSION_1C_3",
				"next_trigger": null
			}
		}
	},
	
	"02_seed": {
		"caller_id": "CALLER_SEED_2",
		"initial_text": "HOOK_TAG_2",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_2",
		"success_text": "SUCCESS_REPLY_2A",
		 "next_trigger_success": "02_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_2B",
				"next_trigger": "02_exp_b"
			},
			"WRONG_TARGET_C_2": {
				"chaos_text": "CHAOS_REPLY_2C",
				"next_target": "02_exp_c"
			}
		}
	},
	# --- EXPANSION 2A (Desdobramento do Sucesso) ---
	"02_exp_a": {
		"caller_id": "CALLER_EXP_2A",
		"initial_text": "HOOK_EXP_2A",
		
		"correct_target": "SUCCESS_TARGET_2A",
		"success_text": "CONCLUSION_2A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null, 
		
		"wrong_targets": {
			"ERROR_TARGET_2A_2": {
				"chaos_text": "CONCLUSION_2A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_2A_3": {
				"chaos_text": "CONCLUSION_2A_3",
				"next_trigger": null
			}
		}
	},
	
	# --- EXPANSION 2B (Desdobramento do Caos 1) ---
	"02_exp_b": {
		"caller_id": "CALLER_EXP_2B",
		"initial_text": "HOOK_EXP_2B",
		
		"correct_target": "SUCCESS_TARGET_2B",
		"success_text": "CONCLUSION_2B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_2B_2": {
				"chaos_text": "CONCLUSION_2B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_2B_3": {
				"chaos_text": "CONCLUSION_2B_3",
				"next_trigger": null
			}
		}
	},
	
	# --- EXPANSION 2C (Desdobramento do Caos 2) ---
	"02_exp_c": {
		"caller_id": "CALLER_EXP_2C",
		"initial_text": "HOOK_EXP_2C",
		
		"correct_target": "SUCCESS_TARGET_2C",
		"success_text": "CONCLUSION_2C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_2C_2": {
				"chaos_text": "CONCLUSION_2C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_2C_3": {
				"chaos_text": "CONCLUSION_2C_3",
				"next_trigger": null
			}
		}
	},
	
	"03_seed": {
		"caller_id": "CALLER_SEED_3",
		"initial_text": "HOOK_TAG_3",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_3",
		"success_text": "SUCCESS_REPLY_3A",
		 "next_trigger_success": "03_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_3B",
				"next_trigger": "03_exp_b"
			},
			"WRONG_TARGET_C_1": {
				"chaos_text": "CHAOS_REPLY_3C",
				"next_target": "03_exp_c"
			}
		}
	},
	# --- EXPANSION 3A (Desdobramento do Sucesso) ---
	"03_exp_a": {
		"caller_id": "CALLER_EXP_3A",
		"initial_text": "HOOK_EXP_3A",
		
		"correct_target": "SUCCESS_TARGET_1A",
		"success_text": "CONCLUSION_3A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null, 
		
		"wrong_targets": {
			"ERROR_TARGET_3A_2": {
				"chaos_text": "CONCLUSION_3A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_3A_3": {
				"chaos_text": "CONCLUSION_3A_3",
				"next_trigger": null
			}
		}
	},
	
	# --- EXPANSION 1B (Desdobramento do Caos 1) ---
	"03_exp_b": {
		"caller_id": "CALLER_EXP_3B",
		"initial_text": "HOOK_EXP_3B",
		
		"correct_target": "SUCCESS_TARGET_3B",
		"success_text": "CONCLUSION_3B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_3B_2": {
				"chaos_text": "CONCLUSION_3B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_3B_3": {
				"chaos_text": "CONCLUSION_3B_3",
				"next_trigger": null
			}
		}
	},
	
	# --- EXPANSION 1C (Desdobramento do Caos 2) ---
	"03_exp_c": {
		"caller_id": "CALLER_EXP_3C",
		"initial_text": "HOOK_EXP_3C",
		
		"correct_target": "SUCCESS_TARGET_3C",
		"success_text": "CONCLUSION_3C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_3C_2": {
				"chaos_text": "CONCLUSION_3C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_3C_3": {
				"chaos_text": "CONCLUSION_3C_3",
				"next_trigger": null
			}
		}
	},
	
	"04_seed": {
		"caller_id": "CALLER_SEED_4",
		"initial_text": "HOOK_TAG_4",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_4",
		"success_text": "SUCCESS_REPLY_4A",
		 "next_trigger_success": "04_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_4B",
				"next_trigger": "04_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_4C",
				"next_target": "04_exp_c"
			}
		}
	},
	# --- EXPANSION 4A (Desdobramento do Sucesso) ---
	"04_exp_a": {
		"caller_id": "CALLER_EXP_4A",
		"initial_text": "HOOK_EXP_4A",
		
		"correct_target": "SUCCESS_TARGET_4A",
		"success_text": "CONCLUSION_4A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null, 
		
		"wrong_targets": {
			"ERROR_TARGET_4A_2": {
				"chaos_text": "CONCLUSION_4A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_4A_3": {
				"chaos_text": "CONCLUSION_4A_3",
				"next_trigger": null
			}
		}
	},
	
	# --- EXPANSION 4B (Desdobramento do Caos 1) ---
	"04_exp_b": {
		"caller_id": "CALLER_EXP_4B",
		"initial_text": "HOOK_EXP_4B",
		
		"correct_target": "SUCCESS_TARGET_4B",
		"success_text": "CONCLUSION_4B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_4B_2": {
				"chaos_text": "CONCLUSION_4B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_4B_3": {
				"chaos_text": "CONCLUSION_4B_3",
				"next_trigger": null
			}
		}
	},
	
	# --- EXPANSION 4C (Desdobramento do Caos 2) ---
	"04_exp_c": {
		"caller_id": "CALLER_EXP_4C",
		"initial_text": "HOOK_EXP_4C",
		
		"correct_target": "SUCCESS_TARGET_4C",
		"success_text": "CONCLUSION_4C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_4C_2": {
				"chaos_text": "CONCLUSION_4C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_4C_3": {
				"chaos_text": "CONCLUSION_4C_3",
				"next_trigger": null
			}
		}
	},
	
	"05_seed": {
		"caller_id": "CALLER_SEED_5",
		"initial_text": "HOOK_TAG_5",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_5",
		"success_text": "SUCCESS_REPLY_5A",
		"next_trigger_success": "05_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_5B",
				"next_trigger": "05_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_5C",
				"next_target": "05_exp_c"
			}
		}
	},

	# --- EXPANSION 5A (Desdobramento do Sucesso) ---
	"05_exp_a": {
		"caller_id": "CALLER_EXP_5A",
		"initial_text": "HOOK_EXP_5A",
		
		"correct_target": "SUCCESS_TARGET_5A",
		"success_text": "CONCLUSION_5A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_5A_2": {
				"chaos_text": "CONCLUSION_5A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_5A_3": {
				"chaos_text": "CONCLUSION_5A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 5B (Desdobramento do Caos 1) ---
	"05_exp_b": {
		"caller_id": "CALLER_EXP_5B",
		"initial_text": "HOOK_EXP_5B",
		
		"correct_target": "SUCCESS_TARGET_5B",
		"success_text": "CONCLUSION_5B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_5B_2": {
				"chaos_text": "CONCLUSION_5B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_5B_3": {
				"chaos_text": "CONCLUSION_5B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 5C (Desdobramento do Caos 2) ---
	"05_exp_c": {
		"caller_id": "CALLER_EXP_5C",
		"initial_text": "HOOK_EXP_5C",
		
		"correct_target": "SUCCESS_TARGET_5C",
		"success_text": "CONCLUSION_5C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_5C_2": {
				"chaos_text": "CONCLUSION_5C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_5C_3": {
				"chaos_text": "CONCLUSION_5C_3",
				"next_trigger": null
			}
		}
	},
	
	"06_seed": {
		"caller_id": "CALLER_SEED_6",
		"initial_text": "HOOK_TAG_6",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_6",
		"success_text": "SUCCESS_REPLY_6A",
		"next_trigger_success": "06_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_6B",
				"next_trigger": "06_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_6C",
				"next_target": "06_exp_c"
			}
		}
	},

	# --- EXPANSION 6A (Desdobramento do Sucesso) ---
	"06_exp_a": {
		"caller_id": "CALLER_EXP_6A",
		"initial_text": "HOOK_EXP_6A",
		
		"correct_target": "SUCCESS_TARGET_6A",
		"success_text": "CONCLUSION_6A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_6A_2": {
				"chaos_text": "CONCLUSION_6A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_6A_3": {
				"chaos_text": "CONCLUSION_6A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 6B (Desdobramento do Caos 1) ---
	"06_exp_b": {
		"caller_id": "CALLER_EXP_6B",
		"initial_text": "HOOK_EXP_6B",
		
		"correct_target": "SUCCESS_TARGET_6B",
		"success_text": "CONCLUSION_6B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_6B_2": {
				"chaos_text": "CONCLUSION_6B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_6B_3": {
				"chaos_text": "CONCLUSION_6B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 6C (Desdobramento do Caos 2) ---
	"06_exp_c": {
		"caller_id": "CALLER_EXP_6C",
		"initial_text": "HOOK_EXP_6C",
		
		"correct_target": "SUCCESS_TARGET_6C",
		"success_text": "CONCLUSION_6C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_6C_2": {
				"chaos_text": "CONCLUSION_6C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_6C_3": {
				"chaos_text": "CONCLUSION_6C_3",
				"next_trigger": null
			}
		}
	},
	
	"07_seed": {
		"caller_id": "CALLER_SEED_7",
		"initial_text": "HOOK_TAG_7",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_7",
		"success_text": "SUCCESS_REPLY_7A",
		"next_trigger_success": "07_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_7B",
				"next_trigger": "07_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_7C",
				"next_target": "07_exp_c"
			}
		}
	},

	# --- EXPANSION 7A (Desdobramento do Sucesso) ---
	"07_exp_a": {
		"caller_id": "CALLER_EXP_7A",
		"initial_text": "HOOK_EXP_7A",
		
		"correct_target": "SUCCESS_TARGET_7A",
		"success_text": "CONCLUSION_7A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_7A_2": {
				"chaos_text": "CONCLUSION_7A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_7A_3": {
				"chaos_text": "CONCLUSION_7A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 7B (Desdobramento do Caos 1) ---
	"07_exp_b": {
		"caller_id": "CALLER_EXP_7B",
		"initial_text": "HOOK_EXP_7B",
		
		"correct_target": "SUCCESS_TARGET_7B",
		"success_text": "CONCLUSION_7B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_7B_2": {
				"chaos_text": "CONCLUSION_7B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_7B_3": {
				"chaos_text": "CONCLUSION_7B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 7C (Desdobramento do Caos 2) ---
	"07_exp_c": {
		"caller_id": "CALLER_EXP_7C",
		"initial_text": "HOOK_EXP_7C",
		
		"correct_target": "SUCCESS_TARGET_7C",
		"success_text": "CONCLUSION_7C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_7C_2": {
				"chaos_text": "CONCLUSION_7C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_7C_3": {
				"chaos_text": "CONCLUSION_7C_3",
				"next_trigger": null
			}
		}
	},
	
	"08_seed": {
		"caller_id": "CALLER_SEED_8",
		"initial_text": "HOOK_TAG_8",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_8",
		"success_text": "SUCCESS_REPLY_8A",
		"next_trigger_success": "08_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_8B",
				"next_trigger": "08_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_8C",
				"next_target": "08_exp_c"
			}
		}
	},

	# --- EXPANSION 8A (Desdobramento do Sucesso) ---
	"08_exp_a": {
		"caller_id": "CALLER_EXP_8A",
		"initial_text": "HOOK_EXP_8A",
		
		"correct_target": "SUCCESS_TARGET_8A",
		"success_text": "CONCLUSION_8A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_8A_2": {
				"chaos_text": "CONCLUSION_8A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_8A_3": {
				"chaos_text": "CONCLUSION_8A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 8B (Desdobramento do Caos 1) ---
	"08_exp_b": {
		"caller_id": "CALLER_EXP_8B",
		"initial_text": "HOOK_EXP_8B",
		
		"correct_target": "SUCCESS_TARGET_8B",
		"success_text": "CONCLUSION_8B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_8B_2": {
				"chaos_text": "CONCLUSION_8B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_8B_3": {
				"chaos_text": "CONCLUSION_8B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 8C (Desdobramento do Caos 2) ---
	"08_exp_c": {
		"caller_id": "CALLER_EXP_8C",
		"initial_text": "HOOK_EXP_8C",
		
		"correct_target": "SUCCESS_TARGET_8C",
		"success_text": "CONCLUSION_8C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_8C_2": {
				"chaos_text": "CONCLUSION_8C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_8C_3": {
				"chaos_text": "CONCLUSION_8C_3",
				"next_trigger": null
			}
		}
	},
	
	"09_seed": {
		"caller_id": "CALLER_SEED_9",
		"initial_text": "HOOK_TAG_9",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_9",
		"success_text": "SUCCESS_REPLY_9A",
		"next_trigger_success": "09_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_9B",
				"next_trigger": "09_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_9C",
				"next_target": "09_exp_c"
			}
		}
	},

	# --- EXPANSION 9A (Desdobramento do Sucesso) ---
	"09_exp_a": {
		"caller_id": "CALLER_EXP_9A",
		"initial_text": "HOOK_EXP_9A",
		
		"correct_target": "SUCCESS_TARGET_9A",
		"success_text": "CONCLUSION_9A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_9A_2": {
				"chaos_text": "CONCLUSION_9A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_9A_3": {
				"chaos_text": "CONCLUSION_9A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 9B (Desdobramento do Caos 1) ---
	"09_exp_b": {
		"caller_id": "CALLER_EXP_9B",
		"initial_text": "HOOK_EXP_9B",
		
		"correct_target": "SUCCESS_TARGET_9B",
		"success_text": "CONCLUSION_9B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_9B_2": {
				"chaos_text": "CONCLUSION_9B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_9B_3": {
				"chaos_text": "CONCLUSION_9B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 9C (Desdobramento do Caos 2) ---
	"09_exp_c": {
		"caller_id": "CALLER_EXP_9C",
		"initial_text": "HOOK_EXP_9C",
		
		"correct_target": "SUCCESS_TARGET_9C",
		"success_text": "CONCLUSION_9C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_9C_2": {
				"chaos_text": "CONCLUSION_9C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_9C_3": {
				"chaos_text": "CONCLUSION_9C_3",
				"next_trigger": null
			}
		}
	},
	
	"10_seed": {
		"caller_id": "CALLER_SEED_10",
		"initial_text": "HOOK_TAG_10",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_10",
		"success_text": "SUCCESS_REPLY_10A",
		"next_trigger_success": "10_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_10B",
				"next_trigger": "10_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_10C",
				"next_target": "10_exp_c"
			}
		}
	},

	# --- EXPANSION 10A (Desdobramento do Sucesso) ---
	"10_exp_a": {
		"caller_id": "CALLER_EXP_10A",
		"initial_text": "HOOK_EXP_10A",
		
		"correct_target": "SUCCESS_TARGET_10A",
		"success_text": "CONCLUSION_10A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_10A_2": {
				"chaos_text": "CONCLUSION_10A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_10A_3": {
				"chaos_text": "CONCLUSION_10A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 10B (Desdobramento do Caos 1) ---
	"10_exp_b": {
		"caller_id": "CALLER_EXP_10B",
		"initial_text": "HOOK_EXP_10B",
		
		"correct_target": "SUCCESS_TARGET_10B",
		"success_text": "CONCLUSION_10B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_10B_2": {
				"chaos_text": "CONCLUSION_10B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_10B_3": {
				"chaos_text": "CONCLUSION_10B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 10C (Desdobramento do Caos 2) ---
	"10_exp_c": {
		"caller_id": "CALLER_EXP_10C",
		"initial_text": "HOOK_EXP_10C",
		
		"correct_target": "SUCCESS_TARGET_10C",
		"success_text": "CONCLUSION_10C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_10C_2": {
				"chaos_text": "CONCLUSION_10C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_10C_3": {
				"chaos_text": "CONCLUSION_10C_3",
				"next_trigger": null
			}
		}
	},
	
	"11_seed": {
		"caller_id": "CALLER_SEED_11",
		"initial_text": "HOOK_TAG_11",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_11",
		"success_text": "SUCCESS_REPLY_11A",
		"next_trigger_success": "11_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_11B",
				"next_trigger": "11_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_11C",
				"next_target": "11_exp_c"
			}
		}
	},

	# --- EXPANSION 11A (Desdobramento do Sucesso) ---
	"11_exp_a": {
		"caller_id": "CALLER_EXP_11A",
		"initial_text": "HOOK_EXP_11A",
		
		"correct_target": "SUCCESS_TARGET_11A",
		"success_text": "CONCLUSION_11A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_11A_2": {
				"chaos_text": "CONCLUSION_11A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_11A_3": {
				"chaos_text": "CONCLUSION_11A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 11B (Desdobramento do Caos 1) ---
	"11_exp_b": {
		"caller_id": "CALLER_EXP_11B",
		"initial_text": "HOOK_EXP_11B",
		
		"correct_target": "SUCCESS_TARGET_11B",
		"success_text": "CONCLUSION_11B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_11B_2": {
				"chaos_text": "CONCLUSION_11B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_11B_3": {
				"chaos_text": "CONCLUSION_11B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 11C (Desdobramento do Caos 2) ---
	"11_exp_c": {
		"caller_id": "CALLER_EXP_11C",
		"initial_text": "HOOK_EXP_11C",
		
		"correct_target": "SUCCESS_TARGET_11C",
		"success_text": "CONCLUSION_11C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_11C_2": {
				"chaos_text": "CONCLUSION_11C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_11C_3": {
				"chaos_text": "CONCLUSION_11C_3",
				"next_trigger": null
			}
		}
	},
	
	"12_seed": {
		"caller_id": "CALLER_SEED_12",
		"initial_text": "HOOK_TAG_12",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_12",
		"success_text": "SUCCESS_REPLY_12A",
		"next_trigger_success": "12_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_12B",
				"next_trigger": "12_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_12C",
				"next_target": "12_exp_c"
			}
		}
	},

	# --- EXPANSION 12A (Desdobramento do Sucesso) ---
	"12_exp_a": {
		"caller_id": "CALLER_EXP_12A",
		"initial_text": "HOOK_EXP_12A",
		
		"correct_target": "SUCCESS_TARGET_12A",
		"success_text": "CONCLUSION_12A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_12A_2": {
				"chaos_text": "CONCLUSION_12A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_12A_3": {
				"chaos_text": "CONCLUSION_12A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 12B (Desdobramento do Caos 1) ---
	"12_exp_b": {
		"caller_id": "CALLER_EXP_12B",
		"initial_text": "HOOK_EXP_12B",
		
		"correct_target": "SUCCESS_TARGET_12B",
		"success_text": "CONCLUSION_12B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_12B_2": {
				"chaos_text": "CONCLUSION_12B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_12B_3": {
				"chaos_text": "CONCLUSION_12B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 12C (Desdobramento do Caos 2) ---
	"12_exp_c": {
		"caller_id": "CALLER_EXP_12C",
		"initial_text": "HOOK_EXP_12C",
		
		"correct_target": "SUCCESS_TARGET_12C",
		"success_text": "CONCLUSION_12C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_12C_2": {
				"chaos_text": "CONCLUSION_12C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_12C_3": {
				"chaos_text": "CONCLUSION_12C_3",
				"next_trigger": null
			}
		}
	},
	
	"13_seed": {
		"caller_id": "CALLER_SEED_13",
		"initial_text": "HOOK_TAG_13",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_13",
		"success_text": "SUCCESS_REPLY_13A",
		"next_trigger_success": "13_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_13B",
				"next_trigger": "13_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_13C",
				"next_target": "13_exp_c"
			}
		}
	},

	# --- EXPANSION 13A (Desdobramento do Sucesso) ---
	"13_exp_a": {
		"caller_id": "CALLER_EXP_13A",
		"initial_text": "HOOK_EXP_13A",
		
		"correct_target": "SUCCESS_TARGET_13A",
		"success_text": "CONCLUSION_13A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_13A_2": {
				"chaos_text": "CONCLUSION_13A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_13A_3": {
				"chaos_text": "CONCLUSION_13A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 13B (Desdobramento do Caos 1) ---
	"13_exp_b": {
		"caller_id": "CALLER_EXP_13B",
		"initial_text": "HOOK_EXP_13B",
		
		"correct_target": "SUCCESS_TARGET_13B",
		"success_text": "CONCLUSION_13B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_13B_2": {
				"chaos_text": "CONCLUSION_13B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_13B_3": {
				"chaos_text": "CONCLUSION_13B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 13C (Desdobramento do Caos 2) ---
	"13_exp_c": {
		"caller_id": "CALLER_EXP_13C",
		"initial_text": "HOOK_EXP_13C",
		
		"correct_target": "SUCCESS_TARGET_13C",
		"success_text": "CONCLUSION_13C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_13C_2": {
				"chaos_text": "CONCLUSION_13C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_13C_3": {
				"chaos_text": "CONCLUSION_13C_3",
				"next_trigger": null
			}
		}
	},
	
		"14_seed": {
		"caller_id": "CALLER_SEED_14",
		"initial_text": "HOOK_TAG_14",
		# Caminho principal (sucesso)
		"correct_target": "CORRECT_TARGET_14",
		"success_text": "SUCCESS_REPLY_14A",
		"next_trigger_success": "14_exp_a",
		
		# Mapeamento de erros
		"wrong_targets": {
			"WRONG_TARGET_B_1": {
				"chaos_text": "CHAOS_REPLY_14B",
				"next_trigger": "14_exp_b"
			},
			"WRONG_TARGET_C": {
				"chaos_text": "CHAOS_REPLY_14C",
				"next_target": "14_exp_c"
			}
		}
	},

	# --- EXPANSION 14A (Desdobramento do Sucesso) ---
	"14_exp_a": {
		"caller_id": "CALLER_EXP_14A",
		"initial_text": "HOOK_EXP_14A",
		
		"correct_target": "SUCCESS_TARGET_14A",
		"success_text": "CONCLUSION_14A_1",
		# Uso do 'null' como flag de parada. O sistema de UI saberá que o arco acabou.
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_14A_2": {
				"chaos_text": "CONCLUSION_14A_2",
				"next_trigger": null
			},
			"ERROR_TARGET_14A_3": {
				"chaos_text": "CONCLUSION_14A_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 14B (Desdobramento do Caos 1) ---
	"14_exp_b": {
		"caller_id": "CALLER_EXP_14B",
		"initial_text": "HOOK_EXP_14B",
		
		"correct_target": "SUCCESS_TARGET_14B",
		"success_text": "CONCLUSION_14B_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_14B_2": {
				"chaos_text": "CONCLUSION_14B_2",
				"next_trigger": null
			},
			"ERROR_TARGET_14B_3": {
				"chaos_text": "CONCLUSION_14B_3",
				"next_trigger": null
			}
		}
	},

	# --- EXPANSION 14C (Desdobramento do Caos 2) ---
	"14_exp_c": {
		"caller_id": "CALLER_EXP_14C",
		"initial_text": "HOOK_EXP_14C",
		
		"correct_target": "SUCCESS_TARGET_14C",
		"success_text": "CONCLUSION_14C_1",
		"next_trigger_success": null,
		
		"wrong_targets": {
			"ERROR_TARGET_14C_2": {
				"chaos_text": "CONCLUSION_14C_2",
				"next_trigger": null
			},
			"ERROR_TARGET_14C_3": {
				"chaos_text": "CONCLUSION_14C_3",
				"next_trigger": null
			}
		}
	}
}
