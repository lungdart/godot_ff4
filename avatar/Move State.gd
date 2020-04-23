extends "State.gd"

export var speed = 2.0
export var tile_size = 16
var direction
var start_position
var completion

onready var animation_player = $"../../AnimationPlayer"

func enter():
	start_position = owner.position
	completion = 0.0
	direction = _get_direction()

	
func exit():
	direction = Vector2.ZERO
	completion = 0.0
	
func update(delta):
	# Increment step into next tile
	completion += speed * delta
	if completion < 1.0:
		owner.position = start_position + (direction * tile_size * completion)
		return
		
	# Step into next tile is completed
	completion = 1.0
	owner.position = start_position + (direction * tile_size)
	
	# Finish moving if there are no more movement actions being given
	direction = _get_direction()
	if direction == Vector2.ZERO:
		emit_signal("finished", "Idle")
		return
		
	# Otherwise, start moving again!
	start_position = owner.position
	completion = 0.0
	
func _get_direction():
	if Input.is_action_pressed("move_up"):
		animation_player.play("Move Up")
		return Vector2.UP

	if Input.is_action_pressed("move_down"):
		animation_player.play("Move Down")
		return Vector2.DOWN

	if Input.is_action_pressed("move_left"):
		animation_player.play("Move Left")
		return Vector2.LEFT

	if Input.is_action_pressed("move_right"):
		animation_player.play("Move Right")
		return Vector2.RIGHT
		
	animation_player.stop()
	return Vector2.ZERO
