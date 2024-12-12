class_name State extends Node

signal Transitioned

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func transition_to(new_state: String):
	Transitioned.emit(self, new_state)
