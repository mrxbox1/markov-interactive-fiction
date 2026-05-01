extends RichTextLabel

var text_string = FileAccess.get_file_as_string("texts/sample.txt")
var text_markovified = {}



func markovify_text(input_text):
	var text_split = input_text.replace(" ", "|").replace("\n", "|")
	text_split = input_text.split("|")
	
	for word in len(text_split)-1:
		#print(text_split[word])
		text_markovified[text_split[word]] = []
		
		for other_word in len(text_split)-1:
			if text_split[other_word] == text_split[word]:
				text_markovified[text_split[word]].append(text_split[other_word+1])



func create_text():
	var random_word = text_markovified.keys().pick_random()
	var resulting_text = ""
	
	



func _ready() -> void:
	print(text_markovified)
	markovify_text(text_string)
