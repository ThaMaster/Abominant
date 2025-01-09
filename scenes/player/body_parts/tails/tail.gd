extends Bodypart
class_name Tail

func _ready() -> void:
	bodypart_slot = GlobalUtilities.BodypartSlot.TAIL

func get_base_stat_dictionary() -> Dictionary:
	var stats: Dictionary
	for upgrade in upgrades:
		GlobalUtilities.append_stats(stats, upgrade.get_buff_dictionary())
	return stats