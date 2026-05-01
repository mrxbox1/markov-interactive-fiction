extends RichTextLabel

var text_string = FileAccess.get_file_as_string("texts/sample.txt")
var text_markovified = {}

var text_split = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_split = text_string.replace(" ", "|").replace("\n", "|")
	text_split = text_split.split("|")
	
	for word in len(text_split)-1:
		#print(text_split[word])
		text_markovified[text_split[word]] = []
		
	print(text_markovified)
	
	text = str(text_split)
