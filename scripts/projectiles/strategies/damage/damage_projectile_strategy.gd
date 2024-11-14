extends BaseProjectileStrategy
class_name DamageProjectileStrategy

@export var damage_increase : float = 5.0

func apply_upgrade(projectile : Projectile):
	projectile.damage += damage_increase
