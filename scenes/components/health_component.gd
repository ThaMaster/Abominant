extends Node2D
class_name HealthComponent

# Actual values
@export var max_health: float = 10
var current_health: float = 10
var current_health_percent: float = (current_health / max_health) if max_health > 0.0 else 0.0

# Booleans
@export var suppress_damage_float: bool = false
var has_health_remaining: bool = is_equal_approx(current_health, 0)
var has_died: bool = false
var is_damaged: bool = current_health < max_health 

func _ready() -> void:
	init_health()

func take_damage(damage: float, _force_hide_damage: bool = false):
	current_health -= damage
	# if(!suppress_damage_float or !force_hide_damage):
		# Show damage numbers here!

func heal(health: float):
	take_damage(-health, true)

func init_health():
	current_health = max_health

func set_max_health(health: float):
	max_health = health
	if current_health > max_health:
		current_health = max_health

func set_current_health(health: float):
	var previous_health = current_health
	current_health = clamp(health, 0, max_health)
	if !has_health_remaining and !has_died:
		has_died = true
