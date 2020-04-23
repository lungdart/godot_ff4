extends Node

signal state_changed
signal free

onready var state_map = {}
var states_stack = []
var current_state = null

# States added here will use the state stack instead of complete state overruling
export var stackable_states = []
export var default_state = ""

func _ready():
	# Add each child dynamically
	var states = get_children()
	for state in states:
		print("Adding state: ", state.name)
		state_map[state.name] = state
		state.connect("finished", self, "_change_state")

	# Trigger 
	current_state = states[0]
	_change_state(states[0].name)

func _physics_process(delta):
	current_state.update(delta)
	
func _input(event):
	current_state.handle_input(event)
	
func _on_animation_finished(animation_name):
	current_state._on_animation_finished(animation_name)
	
func _change_state(state_name):	
	# Handle special states
	if state_name == "previous":
		current_state.exit()
		states_stack.pop_front()
	elif state_name == "free":
		current_state.exit()
		emit_signal("free")
		return
		
	# Jump into stackable state temporarily
	elif state_name in stackable_states:
		states_stack.push_front(state_map[state_name])

	# DEFAULT - Replace the state stack with the new primary state
	else:
		current_state.exit()
		states_stack = [state_map[state_name]]


	current_state = states_stack[0]
	if state_name != "previous":
		current_state.enter()
	emit_signal("state_changed", states_stack)
