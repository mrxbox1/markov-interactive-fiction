extends Control

var textures = ["cubed.png", "fish.png", "flower.png", "gener_ation.png",
				"insanity.png", "it_aint_aligned.png", "not_fish.png", "square_inception.png",
				"meaningless.png", "squared.png", "landscaped.png", "alphabetfrantic.png",
				"tunnell.png"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = load("res://textures/" + textures.pick_random())
	$TextureRect.modulate = Color(randf(), randf(), randf())
	
	$Parallax2D/Sprite2D.visible = bool(randi_range(0,1))
	$Parallax2D/Sprite2D.modulate = Color(randf(), randf(), randf())
	
	$Parallax2D.autoscroll.x = randf_range(-20.0, 20.0)
	$Parallax2D.autoscroll.y = randf_range(-20.0, 20.0)
