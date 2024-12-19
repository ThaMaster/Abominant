extends BaseProjectileStrategy
class_name SpeedProjectileStrategy 

@export var speed_increase : float = 5.0

func apply_upgrade(projectile : ProjectileComponent):
	projectile.speed += speed_increase

# Function for displaying the stats gained from the strategy in the interface.
func get_buff_dictionary() -> Dictionary:
	var buffs: Dictionary
	buffs["speed"] = speed_increase
	return buffs
