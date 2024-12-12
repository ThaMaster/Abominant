class_name EnemySpawner extends Area2D

@onready var spawn_timer: Timer = $SpawnTimer

# Exported variables for configuration
@export_file var enemy_scene: String  # Drag and drop your enemy scene here
@export var max_enemies: int = 10    # Maximum number of enemies allowed
@export var spawn_delay: float = 1.0 # Delay between spawns (seconds)
@export var spawn_count: int = 1     # Number of enemies to spawn at once

var loaded_enemy : PackedScene
var spawned_enemies: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loaded_enemy = load(enemy_scene)
	spawn_timer.wait_time = spawn_delay
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	for i in range(spawn_count):
		if spawned_enemies.size() >= max_enemies:
			break

		var enemy = loaded_enemy.instantiate()
		var spawn_position = get_random_position_in_area()
		enemy.global_position = spawn_position
		
		add_child(enemy)
		spawned_enemies.append(enemy)
		# Connect to a custom signal for cleanup
		enemy.connect("tree_exited", _on_enemy_removed)

func _on_enemy_removed():
	# We need to find and remove the enemy that has exited the tree
	for enemy in spawned_enemies:
		if !enemy.is_inside_tree():
			spawned_enemies.erase(enemy)
			break  # Once we find the enemy, we can stop searching

# Helper to get a random point inside the Area2D's collision shape
func get_random_position_in_area() -> Vector2:
	if !has_node("CollisionShape2D"):
		push_error("Error: Need CollisionShape2D to determine spawning area!")
	
	var shape : Shape2D = get_node("CollisionShape2D").shape
	if shape is RectangleShape2D:
		var extents = shape.extents
		return global_position + Vector2(
			randf_range(-extents.x, extents.x),
			randf_range(-extents.y, extents.y)
		)
	elif shape is CircleShape2D:
		var radius = shape.radius
		var angle = randf() * PI * 2
		var distance = randf_range(0, radius)
		return global_position + Vector2(
			cos(angle) * distance,
			sin(angle) * distance
		)
	else:
		print("Unsupported shape type: ", shape)
		return global_position  # Fallback position
