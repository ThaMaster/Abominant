extends Area2D
class_name ProjectileComponent

const hit_effect = preload("res://scenes/other/hit_effect.tscn")

@export var damage : float = 10.0
@export var piercing : float = 0.0
@export var speed : float = 1500.0
@export var projectile_range : float = 3000

var hits : int

var direction : Vector2
var start_pos : Vector2

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

func get_projectile_stats() -> Dictionary:
	var stats: Dictionary
	stats["damage"] = damage
	stats["piercing"] = piercing
	stats["speed"] = speed
	stats["range"] = projectile_range
	return stats
