extends BaseProjectileStrategy
class_name PiercingStrategy 

@export var piercing_increase : int = 1

func apply_upgrade(projectile : ProjectileComponent):
	projectile.piercing += piercing_increase

# Function for displaying the stats gained from the strategy in the interface.
func get_buff_dictionary() -> Dictionary:
	var buffs: Dictionary
	buffs["piercing"] = piercing_increase
	return buffs
