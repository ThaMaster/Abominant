extends Bodypart
class_name Legs

@export var speed : float = 600.0
@export var jump_velocity : float = -1000.0

func _ready() -> void:
	bodypart_slot = GlobalUtilities.BodypartSlot.LEGS

func get_speed() -> float:
	return speed
	
func get_jump_velocity() -> float:
	return jump_velocity

# Function for getting a dictionary containing the bodypart base stats.
func get_base_stat_dictionary() -> Dictionary:
	var stats: Dictionary
	stats["speed"] = speed
	stats["jump_velocity"] = -jump_velocity
	return stats
