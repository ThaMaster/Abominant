extends Bodypart
class_name Back

func _ready() -> void:
	bodypart_slot = GlobalUtilities.BodypartSlot.BACK
	
func get_base_stat_dictionary() -> Dictionary:
	return {}
