extends RichTextLabel



var seed = int(Time.get_ticks_msec())
var doitwork = false #bool(randi_range(0,1))

var prefix_name = ["FINKLE", "FAN", "GAR", "GIN", "AR", "AE", "BRUM", "INKLE", "GA", "GAN",
					"DOO", "FIN", "GUN", "AL", "TWO", "THREE", "FOUR", "ONE", "AFTER", "AR",
					"AM", "RAD", "GOO", "WIZ", "FUK", "FACE", "FRANKEN", "WAL", "MICH",
					"MAR", "LU", "WAR", "WALU", "PEA", "BOW", "PO", "CU"]
var suffix_name = ["DORF", "DALF", "FIELD", "BAL", "DERP", "DOOF", "BING", "BUS", "BERG",
					"BONG", "THUR", "BER", "IO", "EKIT", "WER", "LOW", "HIGH", "UP", "DOWN",
					"HAZ", "WIZ", "FUK", "FACE", "STEIN", "TER", "AEL", "IGI", "K", "CH",
					"SER", "RAK"]
# these deaths are purely for absurd purposes only.
var deaths = ["IN A FIRE.", "OF TUBERCULOSIS.", "HAPPY.", "AT THE SIGHT OF NOTHING.", "TO A WEAPON.", 
			"TO A PERSON.", "TO A CREATURE.", "IN VAIN.", "IN PAIN.", "IN SPAIN.",
			"IN BREAD.", "FROM GLUTTONY.", "OF INCOMPETENCE.", "OF DEPRESSION.",
			"OF FOOLISHNESS.", "OF READING.", "OF BREATHING.", "OF SUFFOCATION.",
			"OF DRINKING.", "OF SOMETHING.", "OR SOMETHING.", "A SAILOR.",
			"A PIRATE.", "A HERO.", "A TRAITOR.", "AN IDIOT.", "A FOOL.", "A WARRIOR.",
			"A HORSE.", "AT BAY.", "AT SUNRISE.", "AT DAWN.", "AT MIDNIGHT.",
			"AT A PARTY.", "AND WENT TO HEAVEN.", "AND WENT TO HELL.", "AND BECAME A GHOUL, BUT RAN AWAY.",
			"AND DECIDED TO STOP EXISTING.", "AND MATERIALIZED INTO THIN AIR.", "TO DEATH.",
			"INSIDE OUT.", "UPSIDE DOWN.", "WHILE DRINKING.", "WHILE DRIVING.",
			"WHILE DRINKING AND DRIVING.", "IN DETENTION.", "TO POLICE BRUTALITY.",
			"A DEATH.", "ALIVE.", "DEAD.", "RED.", "BLUE.", "BROKEN.", "FIXED.", "MAGICALLY."]

var files = ["alice_in_wonderland.txt", "frankenstein.txt",
			"adventures_of_roderick_random.txt", "treasure_island.txt"]

var text_string = FileAccess.get_file_as_string("texts/" + files.pick_random()).to_upper()
@export var user_input: Control
@export var status: Label

var current_model

var characters = []
var luck = [randi_range(1,5), randi_range(1,5), randi_range(1,5), randi_range(1,5)]



func build_model(source):
	source = source.replace(" ", "|").replace("\n", "|").split("|")
	var model = {}
	var next_word: String
	
	for i in range(len(source)):
		#print(source[i])
		model[source[i]] = []

	for i in range(len(source)):
		if source[i] != source[-1]:
			next_word = source[i + 1]
		else:
			next_word = ""
		#print("Next word:", next_word)
		model[source[i]].append(next_word)

	model[""] = [""]

	return model



func generate_text(model, length, startwithlastword=false):
	var final_result = []

	var starting_word = model.keys()[randi() % model.keys().size()]
	#print("STARTING WORD:", starting_word)
	if startwithlastword == true: starting_word = get_parsed_text().split(" ")[-1]
	
	var next_word = model[starting_word][randi() % model[starting_word].size()]
	#print("NEXT WORD:", next_word)
	final_result.append(starting_word)
	final_result.append(next_word)
	
	for i in range(length):
		next_word = model[next_word][randi() % model[next_word].size()]
		#print("NEXT WORD:", next_word)
		if next_word == "": next_word = model.keys().pick_random()
		final_result.append(next_word)
	
	final_result.pop_front()
	return final_result



func create_name():
	return prefix_name.pick_random() + suffix_name.pick_random()



func _ready() -> void:
	rand_from_seed(seed)
	
	# let's give the player a name.
	var intro_text = "WELCOME TO THE ADVENTURE OF [unknown]. WE SHALL BEGIN BY GIVING THE PLAYER A NAME."
	characters.append(create_name())
	text = intro_text + " THIS PLAYER WILL BE NAMED " + characters[0] + ". AND SO, THIS ADVENTURE SHALL BEGIN."
	
	current_model = build_model(text_string)



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pull_and_peel_licorice"):
		regenerate()



func regenerate() -> void:
	text = text + " [color=green]" + user_input.text.replace("\n", "").to_upper() + "[/color]"
	
	user_input.text = ""
	
	var additional_model = build_model(get_parsed_text())
	current_model.merge(additional_model)
	text = text + " [color=orange]" + " ".join(generate_text(current_model, randi_range(10,20), doitwork)) + "[/color]"
	text = text.replace("%NAME%", characters.pick_random())
	#print(seed)
	
	if randi_range(1, 10) in luck: 
		characters.append(create_name())
		text = text + ". " + characters[-1] + " JOINED THE PARTY."
	if randi_range(6, 7) in luck:
		text = text + ". " + characters[-1] + "DIED " + deaths.pick_random()
	
	status.text = "FRIENDS: " + str(characters)
