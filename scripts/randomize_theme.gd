extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_theme_stylebox_override("panel", StyleBoxTexture.new())
