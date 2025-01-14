extends CharacterBody2D
class_name Projectile

func get_projectile_component() -> ProjectileComponent:
	return get_node("ProjectileComponent")

func destroy_projectile():
	queue_free()
