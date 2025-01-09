extends Node2D
class_name Bodypart

var upgrades : Array[BaseUpgradeStrategy] = []

@export var bodypart_name : String
@export var bodypart_slot : GlobalUtilities.BodypartSlot
@export var bodypart_image : Texture2D
@export var weapon_side: GlobalUtilities.WeaponSide

func set_weapon_side(new_side: GlobalUtilities.WeaponSide):
	weapon_side = new_side

# Function for getting a dictionary containing the bodypart base stats.
func get_base_stat_dictionary() -> Dictionary:
	var stats: Dictionary
	for upgrade in upgrades:
		GlobalUtilities.append_stats(stats, upgrade.get_buff_dictionary())
	return stats

# Function for getting the complete stat dictionary. Must be implemented by
# the subclases!
func get_stat_dictionary() -> Dictionary:
	# This is a placeholder that raises an error if not implemented
	# by a subclass.
	GlobalUtilities.unimplemented()
	return {}
