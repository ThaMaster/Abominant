extends CharacterBody2D
class_name Bullet 

@onready var projectile_component: Node2D = $ProjectileComponent

func get_projectile_component() -> ProjectileComponent:
	return projectile_component
