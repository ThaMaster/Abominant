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

func handle_projectile_collision(projectile: ProjectileComponent):
	if detect_only:
		return
	if should_accept_projectile(projectile.projectile_owner):
		deal_damage_w_transforms(projectile.damage)
		projectile.perform_hit()

func should_accept_projectile(projectile_owner: String) -> bool:
	var player: bool = (get_parent() is Bodypart and projectile_owner != "player")
	var enemy: bool = (get_parent() is Enemy and projectile_owner != "enemy")
	return  player or enemy

func handle_melee_collision():
	if detect_only:
		return

func handle_entity_collision(_entity: CharacterBody2D):
	if detect_only:
		return

func _on_area_entered(area: Area2D) -> void:
	if area is ProjectileComponent:
		handle_projectile_collision(area)
