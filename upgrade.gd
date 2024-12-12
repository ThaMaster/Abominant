@tool
class_name Upgrade extends Area2D

@export var upgrade_label : Label
@export var sprite : Sprite2D
@export var projectile_strategy : BaseProjectileStrategy
@export var needs_update : bool

func _ready() -> void:
	sprite.texture = projectile_strategy.texture
	upgrade_label.text = projectile_strategy.upgrade_text

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		if needs_update:
			sprite.texture = projectile_strategy.texture
			upgrade_label.text = projectile_strategy.upgrade_text
			needs_update = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.apply_upgrade(projectile_strategy)
		queue_free()
