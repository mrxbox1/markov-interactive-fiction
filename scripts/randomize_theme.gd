extends Control

var textures = ["cubed.png", "fish.png", "flower.png"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.texture = load("res://textures/" + textures.pick_random())
	$TextureRect.modulate = Color(randf(), randf(), randf())
