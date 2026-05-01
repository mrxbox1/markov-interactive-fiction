extends Control

var textures = ["cubed.png", "fish.png", "flower.png", "gener_ation.png",
				"insanity.png", "it_aint_aligned.png", "not_fish.png", "square_inception.png"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = load("res://textures/" + textures.pick_random())
	$TextureRect.modulate = Color(randf(), randf(), randf())
