extends Control

export(Texture) var texture = null setget set_texture
export(String) var character_name = "Name" setget set_name
export(String) var character_class = "Class" setget set_class
export(int) var level = 0 setget set_level
export(int) var max_hp = 0 setget set_max_hp
export(int) var current_hp = 0 setget set_current_hp
export(int) var max_mp = 0 setget set_max_mp
export(int) var current_mp = 0 setget set_current_mp
export(bool) var in_back = false setget set_back
export(int) var back_offset = 12

onready var profile = $Profile
onready var name_label = $Name
onready var level_label = $Level
onready var hp_label = $HP
onready var mp_label = $MP

# Labels will not be populated when the original setter is called on scene
#  change, so set temporary variables, and populate them in when _ready() is
#  called. Setters will populate children only after they exist
var name_text  = "Name     Class"
var level_text   = "Level      0"
var hp_text      = "HP       0/0"
var mp_text      = "MP       0/0"
var back_flag = false

func _ready():
	name_label.text = name_text
	level_label.text = level_text
	hp_label.text = hp_text
	mp_label.text = mp_text
	profile.texture = texture
	if back_flag:
		profile.rect_position.x = back_offset

# Setters
func set_texture(value):
	texture = value
	if profile != null:
		profile.texture = texture
	
func set_name(value):
	character_name = value
	name_text = value + " " + character_class
	if name_label != null:
		name_label.text = name_text

func set_class(value):
	character_class = value
	name_text = character_name + " " + value
	if name_label != null:
		name_label.text = name_text
	
func set_level(value):
	level = value
	var label = "Level"
	var text = String(value)
	var spaces = get_spaces(12, label+text)
	level_text = label + spaces + text
	if level_label != null:
		level_label.text = level_text
	
func set_max_hp(value):
	max_hp = value
	var label = "HP"
	var text = String(current_hp) + "/" + String(value)
	var spaces = get_spaces(12, label+text)
	hp_text = label + spaces + text
	if hp_label != null:
		hp_label.text = hp_text
	
func set_current_hp(value):
	current_hp = value
	var label = "HP"
	var text = String(value) + "/" + String(max_hp)
	var spaces = get_spaces(12, label+text)
	hp_text = label + spaces + text
	if hp_label != null:
		hp_label.text = hp_text
	
func set_max_mp(value):
	max_mp = value
	var label = "MP"
	var text = String(current_mp) + "/" + String(value)
	var spaces = get_spaces(12, label+text)
	mp_text = label + spaces + text
	if mp_label != null:
		mp_label.text = mp_text
	
func set_current_mp(value):
	current_mp = value
	var label = "MP"
	var text = String(value) + "/" + String(max_mp)
	var spaces = get_spaces(12, label+text)
	mp_text = label + spaces + text
	if mp_label != null:
		mp_label.text = mp_text

func set_back(value):
	# Position set to front
	if not value:
		back_flag = false
		if profile != null:
			profile.rect_position.x = 0
	
	# Position set to back
	else:
		back_flag = true
		if profile != null:
			profile.rect_position.x = back_offset

func get_spaces(size, text):
	var count = size - text.length()
	var spaces = " ".repeat(count)
	return spaces
	
