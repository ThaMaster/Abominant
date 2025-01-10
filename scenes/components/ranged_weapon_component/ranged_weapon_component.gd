extends Node2D
class_name RangedWeaponComponent

@onready var weapon_bodypart : Bodypart = get_parent()
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var reload_timer: Timer = $ReloadTimer

# Projectile Stats
@export_range(1, 1000) var damage : float = 10.0
@export_range(0.0, 100) var piercing : float = 0.0
@export_range(1500, 10000) var speed : float = 1500.0
@export_range(1000, 3000) var projectile_range : float = 3000

# Weapon Stats
@export_range(0.5, 10) var fire_rate: float = 0.5
@export_range(1, 100) var ammo_capacity: int = 1
@export_range(1, 50) var projectiles_per_shot: int = 1
@export_range(0, 60) var bullet_spread: float = 0.0
@export_range(1, 20) var reload_time: float = 1.0

# Misc
@export var projectile_scene: PackedScene
@export var projectile_start_position : Marker2D

var current_ammo: int
var can_fire: bool = true
var is_reloading: bool = false

func _ready() -> void:
	current_ammo = ammo_capacity
	fire_rate_timer.wait_time = 1 / fire_rate
	reload_timer.wait_time = reload_time
	
	if not projectile_scene:
		push_error("Error: Must add a bullet scene when using the RangedWeaponComponent!")

func attack(upgrades: Array):
	if can_fire and not is_reloading:
		if current_ammo > 0:
			var bullets_to_fire = min(projectiles_per_shot, current_ammo)
			for i in range(bullets_to_fire):
				var bullet = spawn_projectile()
				for strategy in upgrades:
					strategy.apply_upgrade(bullet.get_projectile_component())
			current_ammo -= bullets_to_fire
			can_fire = false
			fire_rate_timer.start()
			GlobalEventManager.emit_weapon_fired()
			GlobalEventManager.emit_weapon_ammo_changed(weapon_bodypart.weapon_side, current_ammo, ammo_capacity)
		else:
			reload()

func reload():
	if current_ammo < ammo_capacity:
		GlobalEventManager.emit_weapon_reloading(weapon_bodypart.weapon_side, reload_time)
		is_reloading = true
		reload_timer.start()

func spawn_projectile() -> CharacterBody2D:
	var start_pos: Vector2 = projectile_start_position.global_position if projectile_start_position else self.global_position	
	
	var base_direction = (get_global_mouse_position() - start_pos).normalized()
	var spread_angle_radians = deg_to_rad(bullet_spread)
	var random_angle = randf_range(-spread_angle_radians / 2, spread_angle_radians / 2)
	
	# Rotate the base direction by the random spread angle
	var final_direction = base_direction.rotated(random_angle)
	var projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	var pc: ProjectileComponent = projectile.get_projectile_component()
	pc.init(damage, piercing, speed, projectile_range)
	projectile.global_position = start_pos
	pc.start_pos = start_pos
	projectile.rotation = final_direction.angle()
	pc.direction = final_direction
	return projectile

# Function for retrieving the stats of the weapon.
func get_stat_dictionary() -> Dictionary:
	var stats: Dictionary
	stats["damage"] = damage
	stats["piercing"] = piercing
	stats["speed"] = speed
	stats["range"] = projectile_range
	stats["fire_rate"] = fire_rate
	stats["ammo_capacity"] = ammo_capacity
	stats["projectiles_per_shot"] = projectiles_per_shot
	stats["bullet_spread"] = bullet_spread
	stats["reload_time"] = reload_time
	return stats;

func _on_fire_rate_timer_timeout() -> void:
	can_fire = true

func _on_reload_timer_timeout() -> void:
	is_reloading = false
	current_ammo = ammo_capacity
	GlobalEventManager.emit_weapon_ammo_changed(weapon_bodypart.weapon_side, current_ammo, ammo_capacity)
