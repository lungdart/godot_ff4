"""
Base interface for all states. Non functional.
"""
extends Node

signal finished(next_state_name)
var input_stack = []

func enter():
	return
	
func exit():
	return
	
func handle_input(event):
	pass
	
func update(delta):
	return
	
func _on_animation_finished(animation_name):
	return
