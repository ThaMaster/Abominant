extends BaseProjectileStrategy
class_name PiercingStrategy 

@export var piercing_increase : int = 1

func apply_upgrade(projectile : ProjectileComponent):
	projectile.piercing += piercing_increase
