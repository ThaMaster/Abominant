extends Bodypart
class_name Arm

func _ready() -> void:
	bodypart_slot = GlobalUtilities.BodypartSlot.ARM

# Function for getting a dictionary containing the bodypart base stats.
func get_base_stat_dictionary() -> Dictionary:
	var stats: Dictionary
	if has_node("RangedWeaponComponent"):
		var rwc: RangedWeaponComponent = get_node("RangedWeaponComponent")
		GlobalUtilities.append_stats(stats, rwc.get_stat_dictionary())
	elif has_node("MeleeWeaponComponent"):
		# Append the base stats of a melee weapon instead
		pass
	
	for upgrade in upgrades:
		GlobalUtilities.append_stats(stats, upgrade.get_buff_dictionary())
	return stats
