extends Node

const PORT_DIRECTORY: Dictionary = {
	"A1_red": {"location": "Hospital", "default_character": "Dr Daniel"},
	"A1_green": {"location": "Pincer's Family House", "default_character": "Mrs Pincer"},
	"A2_red": {"location": "Big Corp", "default_character": "Big Corp Administrator"},
	"A2_green": {"location": "Johnson's Family House", "default_character": "Mrs Johnson"},
	"A3_red": {"location": "Miller's Family House", "default_character": "Mr Miller"},
	"A3_green": {"location": "Docks", "default_character": "Capitain Sullivan"},
	"A4_red": {"location": "Mafia", "default_character": "Don Rossi"},
	"A4_green": {"location": "Zoo", "default_character": "Zookeeper Griffin"},
	"A5_red": {"location": "Mayor Pincer's Office", "default_character": "Secretary Donna"},
	"A5_green": {"location": "Boss's Office", "default_character": "Boss"},
	"B1_red": {"location": "Firefighters", "default_character": "Chief Caesar"},
	"B1_green": {"location": "Police Precinct", "default_character": "Detective Lane"},
	"B2_red": {"location": "School", "default_character": "Teacher Marianne"},
	"B2_green": {"location": "Church", "default_character": "Father Robinson"},
	"B3_red": {"location": "Thompson's Family House", "default_character": "Mr Thompson"},
	"B3_green": {"location": "Silva's Family House", "default_character": "Mrs Silva"},
	"B4_red": {"location": "Brothel", "default_character": "Pimp De Burgs"},
	"B4_green": {"location": "Bakery", "default_character": "Baker Carl"},
	"B5_red": {"location": "News", "default_character": "Journalist Sandra"},
	"B5_green": {"location": "Restaurant", "default_character": "Chef Clark"} 
}

const CHARACTER_SPRITES: Dictionary = {
	"Dr Daniel": {
		"idle": preload("res://assets/sprites/characters/Dr Daniel.png"),
		"talk": preload("res://assets/sprites/characters/Dr Daniel (mouth open).png")
	},
	"Nurse Laura": {
		"idle": preload("res://assets/sprites/characters/Nurse Laura.png"),
		"talk": preload("res://assets/sprites/characters/Nurse Laura (Mouth Open).png")
	},
	"Mrs Pincer": {
		"idle": preload("res://assets/sprites/characters/Mrs pincer.png"),
		"talk": preload("res://assets/sprites/characters/Mrs pincer (mouth open).png")
	},
	"Big Corp Administrator": {
		"idle": preload("res://assets/sprites/characters/Big Corp Administator.png"),
		"talk": preload("res://assets/sprites/characters/Big Corp Administator (mouth open).png")
	},
	"Mrs Johnson": {
		"idle": preload("res://assets/sprites/characters/Mrs Johnson.png"),
		"talk": preload("res://assets/sprites/characters/Mrs Johnson (open mouth).png")
	},
	"Mr Miller": {
		"idle": preload("res://assets/sprites/characters/Mr Miller.png"),
		"talk": preload("res://assets/sprites/characters/Mr Miller (mouth open).png")
	},
	"Capitain Sullivan": {
		"idle": preload("res://assets/sprites/characters/Capitain Sullivan.png"),
		"talk": preload("res://assets/sprites/characters/Capitain Sullivan (mouth open).png")
	},
	"Don Rossi": {
		"idle": preload("res://assets/sprites/characters/Don Rossi.png"),
		"talk": preload("res://assets/sprites/characters/Don Rossi (Mouth Open).png")
	},
	"Zookeeper Griffin": {
		"idle": preload("res://assets/sprites/characters/Zookeeper Griffin.png"),
		"talk": preload("res://assets/sprites/characters/Zookeeper Griffin (Mouth Open).png")
	},
	"mayor pincer": {
		"idle": preload("res://assets/sprites/characters/mayor pincer.png"),
		"talk": preload("res://assets/sprites/characters/mayor pincer (mouth open).png")
	},
	"Secretary Donna": {
		"idle": preload("res://assets/sprites/characters/Secretary Donna.png"),
		"talk": preload("res://assets/sprites/characters/Secretary Donna (open Mouth).png")
	},
	"Boss": {
		"idle": preload("res://assets/sprites/characters/boss.png"),
		"talk": preload("res://assets/sprites/characters/Boss (open mouth).png")
	},
	"Chief Caesar": {
		"idle": preload("res://assets/sprites/characters/Chief Caesar.png"),
		"talk": preload("res://assets/sprites/characters/Chief Caesar (mouth open).png")
	},
	"Detective Lane": {
		"idle": preload("res://assets/sprites/characters/Detective Lane.png"),
		"talk": preload("res://assets/sprites/characters/Detective Lane (mouth open).png")
	},
	"Teacher Marianne": {
		"idle": preload("res://assets/sprites/characters/Teacher Marianne.png"),
		"talk": preload("res://assets/sprites/characters/Teacher Marianne (mouth open).png")
	},
	"Father Robinson": {
		"idle": preload("res://assets/sprites/characters/Father Robinson.png"),
		"talk": preload("res://assets/sprites/characters/Father Robinson (open mouth).png")
	},
	"Mr Thompson": {
		"idle": preload("res://assets/sprites/characters/Mr Thompson.png"),
		"talk": preload("res://assets/sprites/characters/Mr Thompson (open mouth).png")
	},
	"Mrs Silva": {
		"idle": preload("res://assets/sprites/characters/Mrs Silva.png"),
		"talk": preload("res://assets/sprites/characters/Mrs Silva (open mouth).png")
	},
	"Pimp De Burgs": {
		"idle": preload("res://assets/sprites/characters/Pimp De Burgs.png"),
		"talk": preload("res://assets/sprites/characters/Pimp De Burgs (mouth open).png")
	},
	"Baker Carl": {
		"idle": preload("res://assets/sprites/characters/Bakerl Carl.png"),
		"talk": preload("res://assets/sprites/characters/Bakerl Carl.png")
	},
	"Journalist Sandra": {
		"idle": preload("res://assets/sprites/characters/Journalist Sandra.png"),
		"talk": preload("res://assets/sprites/characters/Journalist Sandra (mouth open).png")
	},
	"Chef Clark": {
		"idle": preload("res://assets/sprites/characters/Chef Clark.png"),
		"talk": preload("res://assets/sprites/characters/Chefl Clark (open mouth).png")
	}
}

const NARRATIVES: Dictionary = {
	"01_seed": { #THE NAKED MAN: Hospital A1_red -> Firefighters B1_red / Zoo A4_green / Bakery B4_green
		"caller_id": "A1_red",
		"initial_text": "Operator! Put me through to someone, quick! 
		He's screaming, knocking over equipment, and nobody can catch him!
		One nurse fainted, another climbed a cabinet!
		Please, connect me before he reaches the maternity ward!",
		# Caminho principal (sucesso)
		"correct_target": "B1_red",
		"success_text": "Say no more, Doctor. 
		We'll send three men, two blankets, and the big rescue net.
		Last week we had to capture a sleepwalker who thought he was an eagle.
		We'll have your naked runner wrapped up in no time.",
		 "next_trigger_success": null,
		
		"wrong_targets": {
			"A4_green": {
				"chaos_text": "Hairless, loud, impossible to catch... 
				Good heavens.
				That's Nigel.
				Our chimp learned how to steal clothes.
				If he's naked again, he must've traded them for cigarettes.
				Do not look him in the eyes.
				We're coming.",
				"next_trigger": null
			},
			"B4_green": {
				"chaos_text": "Blast it.
				Otto's done it again.
				Every summer he decides clothing is optional.
				Tell him his dough isn't finished.
				The fool always comes back when the bread is ready.",
				"next_target": null
			}
		}
	},
	
	"02_seed": { #THE MISSING ATTRACTION: Zoo A4_green -> Docks A3_g / Police B1_r / Big Corp A4_r
		"caller_id": "A4_green",
		"initial_text": "Operator! We have a serious problem!
		One of our biggest attractions vanished during the night!
		The enclosure is empty.
		The fence is broken.
		And we've found footprints leading away from the property!
		Connect me to someone immediately!",
		# Caminho principal (sucesso)
		"correct_target": "A3_green",
		"success_text": "Let me guess.
		Big.
		Heavy.
		Eats everything in sight?
		If it's the rhinoceros, he's down here.
		He's already eaten two ropes and half a crate of cabbages.",
		 "next_trigger_success": null,
		
		"wrong_targets": {
			"B1_red": {
				"chaos_text": "Broken fence.
				Missing attraction.
				Footprints.
				Classic kidnapping.
				Nobody leaves footprints unless they WANT us to find them.
				This goes deeper than you think.",
				"next_trigger": null
			},
			"A4_red": {
				"chaos_text": "Your biggest attraction disappeared?
				Have you checked accounting?
				That's where our valuable assets usually vanish.",
				"next_target": null
			}
		}
	},
	
	"03_seed": { #THE MAN IN SUITS: Big Corp A2_R -> Boss A5_G / Mafia A4_R / Pincer's House A1_G
		"caller_id": "A2_red",
		"initial_text": "Operator, I need assistance immediately.
		Several men in expensive suits have arrived.
		They're demanding payment.
		They're carrying documents.
		And they're smiling.
		Nobody smiles that much unless something terrible is happening.",
		# Caminho principal (sucesso)
		"correct_target": "A5_green",
		"success_text": "Those are auditors.
		Do NOT let them into the records room.
		Do NOT offer them coffee.
		And whatever happens...
		Don't tell them where I am.",
		 "next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A4_red": {
				"chaos_text": "Expensive suits?
				Demanding money?
				Smiling?
				Disgraceful.
				No respectable collector smiles.
				They're amateurs.",
				"next_trigger": null
			},
			"A1_green": {
				"chaos_text": "Men in suits?
				Well, that sounds promising.
				Are any of them unmarried?
				My niece is turning twenty-three.",
				"next_target": null
			}
		}
	},
	
	"04_seed": { #THE HOLY SCANDAL: Church B2_G -> Brothel B4_R / News B5_R / Mayor Office A5_R
		"caller_id": "A1_green",
		"initial_text": "Operator, I require assistance.
		A highly respected member of our community has been spotted entering a place he absolutely should not be entering.
		Several witnesses have seen it.
		The rumors are spreading faster than I can stop them.",
		# Caminho principal (sucesso)
		"correct_target": "B4_red",
		"success_text": "Respected member of the community? 
		That narrows it down to about half my customers.
		Can you be more specific?
		Mayor? Judge? Banker?
		You'd be amazed how little free time respectable people have.",
		 "next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B5_red": {
				"chaos_text": "A scandal?
				Witnesses?
				Public figure?
				Father, you've just described the perfect front page.
				Keep everyone exactly where they are.
				I'm bringing a photographer.",
				"next_trigger": null
			},
			"A5_red": {
				"chaos_text": "A respected citizen entering an inappropriate establishment?
				...Oh dear.
				Please tell me nobody mentioned the mayor.
				Actually...
				Never mind.
				Forget I said anything.",
				"next_target": null
			}
		}
	},
	
	"05_seed": { #THE TINY MONSTERS: School B2_R -> Zoo A4_G / Silva's House B3_G / Miller House A3_R
		"caller_id": "B2_red",
		"initial_text": "Operator...
		They're climbing the furniture.
		Throwing objects.
		Making impossible noises.
		And one of them just bit the principal.
		Please connect me to someone.",
		# Caminho principal (sucesso)
		"correct_target": "B3_green",
		"success_text": "Oh dear.
		The grandchildren escaped again.
		How many are there this time?
		Twelve?
		No, wait.
		That's fewer than usual.",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A4_green": {
				"chaos_text": "Climbing?
				Throwing things?
				Biting authority figures?
				Those are definitely monkeys.
				How many tails do you see?",
				"next_trigger": null
			},
			"A3_red": {
				"chaos_text": "Tiny monsters?
				Ma'am, I hunt boars.
				If the creatures fit inside a classroom...
				They're probably children.",
				"next_target": null
			}
		}
	},
	
	"06_seed": { #THE GIANT DOUGH Bakery B4_G -> Firefighters B1_R / Restaurant B5_G / Thompson's House B3_R
		"caller_id": "B4_green",
		"initial_text": "Operator! The situation is getting out of hand!
		It started small this morning.
		Now it's pushing furniture around.
		And it's still growing!
		At this rate, it'll reach the ceiling before noon!",
		# Caminho principal (sucesso)
		"correct_target": "B1_red",
		"success_text": "Growing, is it?
		We've dealt with runaway dough before.
		Keep all doors closed.
		And for heaven's sake, stop feeding it.",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B5_green": {
				"chaos_text": "Growing?
				Naturally.
				That means it's healthy.
				Have you considered serving it?
				The public loves large portions.",
				"next_trigger": null
			},
			"B3_red": {
				"chaos_text": "Growing dough?
				Impossible.
				My family recipe is perfectly safe.
				...mostly.
				How many barrels did you make?",
				"next_target": null
			}
		}
	},
	
	"07_seed": { #THE MYSTERY CRATE: Docks A3_G -> Mafia A4_R / Hospital A1_R / School B2_R
		"caller_id": "A3_green",
		"initial_text": "Operator, we've got a crate here.
		Nobody knows who sent it.
		Nobody knows what's inside.
		But whatever it is...
		...it's definitely breathing.",
		# Caminho principal (sucesso)
		"correct_target": "A4_red",
		"success_text": "For the last time...
		The crate marked 'Do Not Open Under Any Circumstances'...
		...was not supposed to be delivered yet.
		Put it somewhere cool.
		And whatever you hear inside...
		Don't teach it any words.",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A1_red": {
				"chaos_text": "A breathing crate?
				Have you tried opening it?
				No?
				Then medically speaking, I have very little to work with.",
				"next_trigger": null
			},
			"B2_red": {
				"chaos_text": "Breathing?
				Small?
				Making strange noises?
				One of my students might be in there.
				We lost Kevin during a field trip.",
				"next_target": null
			}
		}
	},
	
	"08_seed": { #THE MAYOR'S DISAPPEAREANCE: Mayor's Office A5_R -> Brothel B4_R / News B5_R / Church B2_G
		"caller_id": "A5_red",
		"initial_text": "Operator, this is an emergency.
		The mayor disappeared during a budget meeting.
		Nobody noticed him leave.
		But three different people swear they saw him entering a very suspicious building.
		If his wife finds out before we do, we're finished.",
		# Caminho principal (sucesso)
		"correct_target": "B4_red",
		"success_text": "Ah.
		The mayor. 
		Private room upstairs?
		Asked us not to write his name down?
		Ordered flowers beforehand?
		Yes, he's here.
		And if anyone asks...
		...he's discussing infrastructure.",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B2_green": {
				"chaos_text": "The mayor came here?
				Wonderful!
				Perhaps he has finally decided to confess.
				I've been praying for that since the election.",
				"next_trigger": null
			},
			"B5_red": {
				"chaos_text": "The mayor vanished?
				Mysterious building?
				Potential affair?
				Operator, don't hang up.
				I'm already printing the headline.",
				"next_target": null
			}
		}
	},
	
	"09_seed": { #THE ANGEL Brothel B4_R -> Hospital A1_R / Church B2_G / Johnson House A2_G 
		"caller_id": "B4_red",
		"initial_text": "Operator, I need somebody to come collect a customer.
		He's standing on a table.
		He's pointing at the ceiling.
		And he keeps shouting that he's seen an angel.
		The problem is...
		The angel appears to be talking back.",
		# Caminho principal (sucesso)
		"correct_target": "A1_red",
		"success_text": "Hallucinations.
		Auditory and visual.
		Very straightforward.
		Keep him calm.
		And try not to argue with the angel.
		We'll send help.",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B2_green": {
				"chaos_text": "An angel?
				Speaking directly to a sinner?
				Remarkable!
				Tell everyone not to move.
				I'll bring holy water.
				And a notebook.",
				"next_trigger": null
			},
			"A2_green": {
				"chaos_text": "An angel?
				Talking?
				Do you know who the angel is?
				No?
				That's alright.
				Give me ten minutes.
				I'll know by then.",
				"next_target": null
			}
		}
	},
	
	"10_seed": { #THE LIVING INGREDIENT: Restaurant B5_G -> Thompsons House B3_R / Docks A3_G / Bakery B4_G
		"caller_id": "B5_green",
		"initial_text": "Operator!
		My supplier has failed me again.
		I need an ingredient delivered immediately.
		And it must arrive alive.
		The entire menu depends on it.",
		# Caminho principal (sucesso)
		"correct_target": "A3_green",
		"success_text": "Alive?
		Good.
		Dead lobsters complain less, but customers complain more.
		I'll send over the freshest crate I've got.",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B4_green": {
				"chaos_text": "Alive?
				Ingredients shouldn't be alive.
				...should they?
				Operator, I suddenly have concerns about this restaurant.",
				"next_trigger": null
			},
			"B3_red": {
				"chaos_text": "Alive?
				You want our sourdough starter.
				She's seventy-three years old.
				Still active.
				Still angry.
				Family treasure.",
				"next_target": null
			}
		}
	},
	
	"11_seed": { #THE TERRIBLE SECRET: Johnson's House A2_G -> News B5_R / Police B1_G / Church B2_G
		"caller_id": "A2_green",
		"initial_text": "Operator, this information is absolutely devastating.
		An entire family could be ruined.
		Reputations destroyed.
		Lives changed forever.
		And I simply cannot keep it to myself.",
		# Caminho principal (sucesso)
		"correct_target": "B5_red",
		"success_text": "Excellent.
		Do you have witnesses?
		Documents?
		Photographs?
		No?
		Well...
		Do you at least have confidence?",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B1_green": {
				"chaos_text": "A family ruined?
				Lives destroyed?
				This sounds criminal.
				Stay exactly where you are.
				And don't spread the information.
				...have you spread the information?
				Of course you have.",
				"next_trigger": null
			},
			"B2_green": {
				"chaos_text": "My child...
				Sometimes the kindest thing is silence.
				Perhaps you should keep this secret.
				...
				Why are you laughing?",
				"next_target": null
			}
		}
	},
	
	"12_seed": { #THE BEAST IN THE BARN: Miller's House A3_R -> Zoo A4_G / Firefighters B1_R / Boss Office A5_G
		"caller_id": "A3_red",
		"initial_text": "Operator.
		There's something enormous inside my barn.
		It's making terrible noises.
		The walls are shaking.
		And none of my dogs are willing to go near it.",
		# Caminho principal (sucesso)
		"correct_target": "A4_green",
		"success_text": "Interesting.
		How many legs?
		You don't know?
		How many eyes?
		You don't know?
		Mr. Miller...
		Have you actually looked inside?",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B1_red": {
				"chaos_text": "Loud noises.
				Shaking walls.
				Dangerous situation.
				Could be structural damage.
				Could be trapped livestock.
				Could be your cousin Earl again.
				We'll bring tools.",
				"next_trigger": null
			},
			"A5_green": {
				"chaos_text": "Something huge.
				Making noise.
				Refusing to leave.
				Congratulations.
				You've described my board of directors.",
				"next_target": null
			}
		}
	},
	
	"13_seed": { #THE BLACKMAIL: Pincer's House A1_G -> Mafia A4_R / Mayor A5_R / News B5_R
		"caller_id": "A1_green",
		"initial_text": "Operator!
		A man has appeared demanding money.
		He claims he knows things about this family.
		Embarrassing things.
		Ridiculous things.
		Some of them may even be true.",
		# Caminho principal (sucesso)
		"correct_target": "A4_red",
		"success_text": "Demanding money?
		Using family secrets?
		Without permission?
		Disgusting.
		There used to be standards in this profession.",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"A5_red": {
				"chaos_text": "Family secrets?
				Public officials involved?
				Please tell me this isn't about the mayor.
				...
				Why do I keep asking questions I don't want answered?",
				"next_trigger": null
			},
			"B5_red": {
				"chaos_text": "Family scandal?
				Potential corruption?
				Anonymous source?
				Mrs. Pincer...
				Have I told you how much I admire civic transparency?",
				"next_target": null
			}
		}
	},
	
	"14_seed": { #THE NOON EXPLOSION: Boss Office A5_G -> Big Corp A2_R / Police B1_G / Silva House B3_G
		"caller_id": "A5_green",
		"initial_text": "Operator.
		We've received a message.
		It says everything will explode at noon.
		Nobody knows what it means.
		And unfortunately...
		...our accounting department believes it.",
		# Caminho principal (sucesso)
		"correct_target": "A2_red",
		"success_text": "Oh.
		That's the annual budget meeting.
		Everything explodes every year.
		Metaphorically.
		Usually.",
		"next_trigger_success": null,
		
		# Mapeamento de erros
		"wrong_targets": {
			"B1_green": {
				"chaos_text": "A threat.
				A deadline.
				Unknown sender.
				Classic mastermind behavior.
				I've been waiting for this.",
				"next_trigger": null
			},
			"B3_green": {
				"chaos_text": "Everything explodes at noon?
				That's normal.
				The grandchildren arrive for lunch at twelve.",
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
