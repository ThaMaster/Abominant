extends Area2D
class_name ProjectileComponent

const hit_effect = preload("res://scenes/particles/hit_effect.tscn")

@export var damage : float
@export var piercing : float
@export var speed : float
@export var projectile_range : float = 3000
@export var apply_gravity: bool = false
@export var gravity_factor: float = 1.0

var hits : int
var direction : Vector2
var start_pos : Vector2
var distance_traveled: float = 0

var projectile_owner: String
var projectile: Projectile

func _ready() -> void:
	if get_parent() is Projectile:
		projectile = get_parent()

func init(in_onwer: String, in_damage: float, in_piercing: float, in_speed: float, in_projectile_range: float, in_apply_gravity: bool):
	projectile_owner = in_onwer
	damage = in_damage
	piercing = in_piercing
	speed = in_speed
	projectile_range = in_projectile_range
	apply_gravity = in_apply_gravity

func set_movement_vectors(start: Vector2, dir: Vector2):
	start_pos = start
	direction = dir
	projectile.velocity = direction.normalized() * speed

func _physics_process(delta: float) -> void:
	if projectile:
		if apply_gravity and not projectile.is_on_floor():
			projectile.velocity += projectile.get_gravity() * gravity_factor * delta
		
		projectile.move_and_slide()
		# Update the projectile's rotation based on its velocity direction
		if projectile.velocity.length() > 0:
			projectile.rotation = projectile.velocity.angle()
		
		# Calculate the distance traveled
		distance_traveled += projectile.global_position.distance_to(start_pos)
		start_pos = projectile.global_position
		# If the projectile has exceeded the range, free it
		if distance_traveled >= projectile_range:
			projectile.destroy_projectile()

func perform_hit():
	hits += 1
	var spawned_effect = hit_effect.instantiate()
	spawned_effect.global_position = global_position
	get_tree().root.add_child(spawned_effect)
	if hits > piercing:
		projectile.destroy_projectile()

func set_projectile_owner(p_owner: String):
	projectile_owner = p_owner

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		projectile.destroy_projectile()
