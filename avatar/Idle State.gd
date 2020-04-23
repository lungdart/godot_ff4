extends "State.gd"


func enter():
	print("Idling state entered")
	
func exit():
	print("Idling state exited")

func handle_input(event):
	if event.is_action_pressed("move_up") or event.is_action_pressed("move_down") or event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		emit_signal("finished", "Move")
