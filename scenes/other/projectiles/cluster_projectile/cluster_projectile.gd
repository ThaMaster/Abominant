extends Projectile
class_name ClusterProjectile

@export_range(1, 50) var projectiles_to_spawn: int = 5
@export_range(1,100) var cluster_damage: float = 1.0
@export var cluster_speed: float = 1500
@export var cluster_range: float = 3000
@export var cluster_gravity: bool = false

const EXPLOSION_EFFECT = preload("res://scenes/particles/explosion_effect.tscn")
const BULLET = preload("res://scenes/other/projectiles/bullet/bullet.tscn")
const PROJECTILE_TRAIL_EFFECT = preload("res://scenes/particles/projectile_trail_effect.tscn")

func _ready() -> void:
	var pc: ProjectileComponent = get_projectile_component()
	pc.set_projectile_owner("player")

func destroy_projectile():
	spawn_projectiles()
	var spawned_effect = EXPLOSION_EFFECT.instantiate()
	spawned_effect.global_position = global_position
	get_tree().root.add_child(spawned_effect)
	queue_free()

func spawn_projectiles():
	var angle_increment = 360.0 / projectiles_to_spawn
	for i in range(projectiles_to_spawn):
		# Calculate the angle in radians
		var angle_rad = deg_to_rad(i * angle_increment)
		# Create a new projectile instance
		var projectile: Projectile = BULLET.instantiate()
		# Add the projectile to the scene tree
		call_deferred("add_projectile_to_tree", projectile, angle_rad)

func add_projectile_to_tree(projectile: Projectile, angle: float):
	get_tree().root.add_child(projectile)
	projectile.add_child(PROJECTILE_TRAIL_EFFECT.instantiate())
	var pc: ProjectileComponent = projectile.get_projectile_component()
	pc.init("player", cluster_damage, 0, cluster_speed, cluster_range, cluster_gravity)
	pc.set_movement_vectors(global_position, Vector2(cos(angle), sin(angle)))
	# Set the position and rotation of the projectile
	projectile.global_position = global_position
	projectile.rotation = angle
