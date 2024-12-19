class_name ProjectileComponent extends Area2D

const hit_effect = preload("res://scenes/other/hit_effect.tscn")

@export var base_damage : float = 10.0
@export var base_piercing : int = 0
@export var base_speed : float = 1500.0
@export var projectile_range : float = 3000

var damage : float
var speed : float
var piercing : int
var hits : int

var direction : Vector2
var start_pos : Vector2

func _ready() -> void:
	damage = base_damage
	speed = base_speed
	piercing = base_piercing

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
