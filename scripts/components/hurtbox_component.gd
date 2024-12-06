extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent
@export var detect_only: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", Callable(self, "on_area_entered"))

func handle_projectile_collisions(projectile: ProjectileComponent):
	var damage = 0.0
	if !detect_only:
		damage = projectile.base_damage
		deal_damage_w_transforms(damage)
		

func can_accept_bullet_collision() -> bool:
	if health_component and health_component.has_health_remaining:
		return true
	else:
		return false

func deal_damage_w_transforms(damage: float):
	if health_component:
		health_component.take_damage(damage)

func on_area_entered(otherArea: Area2D):
	if otherArea is HurtboxComponent:
		if !detect_only:
			deal_damage_w_transforms(10.0)


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
