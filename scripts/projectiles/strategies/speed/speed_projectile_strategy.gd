class_name SpeedProjectileStrategy extends BaseProjectileStrategy

@export var speed_increase : float = 5.0

func apply_upgrade(projectile : ProjectileComponent):
	projectile.speed += speed_increase
