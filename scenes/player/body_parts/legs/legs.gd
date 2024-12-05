extends Node2D

@export var speed : float = 600.0
@export var jump_velocity : float = -1000.0

func get_speed() -> float:
	return speed
	
func get_jump_velocity() -> float:
	return jump_velocity
