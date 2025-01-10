extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent
@export var detect_only : bool
@export var disabled : bool = false

func can_accept_bullet_collision() -> bool:
	if health_component and health_component.has_health_remaining:
		return true
	else:
		return false

func deal_damage_w_transforms(damage: float):
	if health_component:
		health_component.take_damage(damage)
