extends "State.gd"

export var speed = 2
export var tile_size = 16
var distance = 0.0
var direction = Vector2.ZERO

onready var animation_player = $"../../AnimationPlayer"

func enter():
	distance = 0.0
	direction = _get_direction()

func exit():
	direction = Vector2.ZERO

func update(delta):
	# Increment step into next tile, ensuring to clamp step size to prevent overshoot
	var step_size = speed * delta
	distance += step_size
	if distance >= 1.0:
		step_size -= distance - 1.0
		distance = 1.0

	# Apply the appropriate force vector and let the engine handle collisions
	var velocity = step_size * tile_size * direction
	owner.move_and_collide(velocity)
	
	# Movement finished. Keep moving if input exists, otherwise go back to Idle
	if distance >= 1.0:
		distance = 0.0
		direction = _get_direction()
		if direction == Vector2.ZERO:
			emit_signal("finished", "Idle")
	
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
