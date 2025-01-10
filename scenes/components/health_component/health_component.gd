extends Node2D
class_name HealthComponent

# Actual values
@export var max_health: float
var current_health: float 
var current_health_percent: float = 1.0

const dmg_text = preload("res://scenes/ui/other/damage_text.tscn")

# Booleans
var has_health_remaining: bool = true
var has_died: bool = false
var is_damaged: bool = false

func init(init_max_health: float) -> void:
	max_health = init_max_health
	current_health = max_health
	if get_parent() is Bodypart:
		GlobalEventManager.emit_player_health_changed_event(current_health, max_health)

func take_damage(damage: float, force_hide_damage: bool = false):
	set_current_health(current_health - damage)
	
	if get_parent() is Bodypart:
		GlobalEventManager.emit_player_health_changed_event(current_health, max_health)
		if not has_health_remaining:
			GlobalEventManager.emit_player_health_depleted_event()
	
	if(!force_hide_damage):
		var spawned_text = dmg_text.instantiate()
		get_tree().root.add_child(spawned_text)
		spawned_text.global_position = get_parent().global_position
		spawned_text.init_text(str(damage), "basic", false)

func heal(health: float):
	take_damage(-health, true)

func set_max_health(health: float):
	max_health = health
	if current_health > max_health:
		current_health = max_health

func set_current_health(health: float):
	current_health = clamp(health, 0, max_health)
	is_damaged = current_health < max_health 
	has_health_remaining = !is_equal_approx(current_health, 0)
	current_health_percent = (current_health / max_health) if max_health > 0.0 else 0.0
	if !has_health_remaining and !has_died:
		has_died = true
