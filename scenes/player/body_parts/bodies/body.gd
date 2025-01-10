extends Bodypart
class_name Body

@export var max_health: float = 100.0
@export var defence: float = 0.0
@export var weight_capacity: float = 100
@export var electricity_resistance: float = 0.0
@export var fire_resistance: float = 0.0
@export var poison_resistance: float = 0.0
@export var slots: Array[GlobalUtilities.BodypartSlot]

@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var health_component: HealthComponent = $HealthComponent

func _ready() -> void:
	health_component.init(max_health)

func get_hurtbox_component() -> HurtboxComponent:
	return hurtbox_component

func get_health_component() -> HealthComponent:
	return health_component

func get_base_stat_dictionary() -> Dictionary:
	var stats: Dictionary
	stats["max_health"] = max_health
	stats["defence"] = defence
	stats["weight_capacity"] = weight_capacity
	stats["electricity_resistance"] = electricity_resistance
	stats["fire_resistance"] = fire_resistance
	stats["poison_resistance"] = poison_resistance
	
	for slot in slots:
		stats[slot] = 1 if stats[slot] == null else stats[slot] + 1
	
	for upgrade in upgrades:
		GlobalUtilities.append_stats(stats, upgrade.get_buff_dictionary())
	return stats
