extends Bodypart
class_name PowerLegs

@export var speed : float = 600.0
@export var jump_velocity : float = -1000.0

func _ready() -> void:
	bodypart_slot = GlobalUtilities.BodypartSlot.LEGS
	weapon_side = GlobalUtilities.WeaponSide.NONE

func get_speed() -> float:
	return speed
	
func get_jump_velocity() -> float:
	return jump_velocity

func get_stat_dictionary() -> Dictionary:
	return get_base_stat_dictionary()
