extends RichTextLabel



var text_string = FileAccess.get_file_as_string("texts/sample.txt")



func build_model(source):
	source = source.split(" ")
	var model = {}
	var next_word: String
	
	for i in range(len(source)):
		#print(source[i])
		model[source[i]] = []

	for i in range(len(source)):
		if source[i] != source[-1]:
			next_word = source[i + 1]
		else:
			next_word = "..."
		#print("Next word:", next_word)
		model[source[i]].append(next_word)

	model["..."] = ["..."]

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



func _ready() -> void:
	var final_model = build_model(text_string)
	text = " ".join(generate_text(final_model, randi_range(5,50)))
