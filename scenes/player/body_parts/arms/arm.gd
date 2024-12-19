extends Bodypart

@onready var ranged_weapon_component: RangedWeaponComponent = $RangedWeaponComponent

func attack():
	ranged_weapon_component.attack(upgrades)

func get_stat_dictionary() -> Dictionary:
	var stats: Dictionary = get_base_stat_dictionary()
	append_stats(stats, ranged_weapon_component.get_stat_dictionary())
	return stats
