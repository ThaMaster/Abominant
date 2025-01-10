extends BaseProjectileStrategy
class_name DamageProjectileStrategy 

@export var damage_increase : float = 5.0

func apply_upgrade(projectile : ProjectileComponent):
	projectile.damage += damage_increase

# Function for displaying the stats gained from the strategy in the interface.
func get_buff_dictionary() -> Dictionary:
	var buffs: Dictionary
	buffs["damage"] = damage_increase
	return buffs
