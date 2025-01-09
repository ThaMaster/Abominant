extends Legs
class_name PowerLegs

func _ready() -> void:
	bodypart_slot = GlobalUtilities.BodypartSlot.LEGS
	jump_velocity = -3000

func get_stat_dictionary() -> Dictionary:
	return get_base_stat_dictionary()
