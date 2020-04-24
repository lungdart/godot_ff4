extends Control



func _ready():
	theme.default_font = BitmapFont.new()
	theme.default_font.create_from_fnt("res://assets/text.font")
