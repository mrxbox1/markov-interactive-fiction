extends RichTextLabel



var seed = int(Time.get_ticks_msec())

var prefix_name = ["FINKLE", "FAN", "GAR", "GIN", "AR", "AE", "BRUM"]
var suffix_name = ["DORF", "DALF", "FIELD", "BAL"]

var text_string = FileAccess.get_file_as_string("texts/alice_in_wonderland.txt").to_upper()
@export var user_input: Control

var current_model

var characters = []



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



func generate_text(model, length):
	var final_result = []

	var starting_word = model.keys()[randi() % model.keys().size()]
	#print("STARTING WORD:", starting_word)
	
	var next_word = model[starting_word][randi() % model[starting_word].size()]
	#print("NEXT WORD:", next_word)
	final_result.append(starting_word)
	final_result.append(next_word)
	
	for i in range(length):
		next_word = model[next_word][randi() % model[next_word].size()]
		#print("NEXT WORD:", next_word)
		if next_word == "...": break
		final_result.append(next_word)

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
	text = text + " [color=orange]" + " ".join(generate_text(current_model, randi_range(10,20))) + "[/color]"
	text = text.replace("%NAME%", characters.pick_random())
	#print(seed)
