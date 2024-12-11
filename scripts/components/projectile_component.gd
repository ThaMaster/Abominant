extends Area2D
class_name ProjectileComponent

const hit_effect = preload("res://scenes/hit_effect.tscn")

@export var base_damage : float = 10.0
@export var base_speed : float = 1500.0
@export var projectile_range : float = 3000

var damage : float = base_damage
var speed : float = base_speed

var direction : Vector2
var start_pos : Vector2

func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		if body.has_node("HurtboxComponent"):
			var spawned_effect = hit_effect.instantiate()
			spawned_effect.global_position = global_position
			get_tree().root.add_child(spawned_effect)
			var hc : HurtboxComponent = body.get_node("HurtboxComponent")
			hc.deal_damage_w_transforms(base_damage)
		get_parent().queue_free()
