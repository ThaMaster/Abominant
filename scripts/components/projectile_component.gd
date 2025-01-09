extends Area2D
class_name ProjectileComponent

const hit_effect = preload("res://scenes/other/hit_effect.tscn")

var damage : float
var piercing : float
var speed : float
var projectile_range : float
var hits : int
var direction : Vector2
var start_pos : Vector2

func init(in_damage: float, in_piercing: float, in_speed: float, in_projectile_range: float):
	damage = in_damage
	piercing = in_piercing
	speed = in_speed
	projectile_range = in_projectile_range

func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		hits += 1
		if body.has_node("HurtboxComponent"):
			if not body.get_node("HurtboxComponent").disabled:
				var spawned_effect = hit_effect.instantiate()
				spawned_effect.global_position = global_position
				get_tree().root.add_child(spawned_effect)
				var hc : HurtboxComponent = body.get_node("HurtboxComponent")
				hc.deal_damage_w_transforms(damage)
				if hits > piercing:
					get_parent().queue_free()
		else:
			get_parent().queue_free()
