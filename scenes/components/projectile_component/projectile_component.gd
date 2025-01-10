extends Area2D
class_name ProjectileComponent

const hit_effect = preload("res://scenes/other/hit_effect.tscn")

var damage : float
var piercing : float
var speed : float
var projectile_range : float
var hits : int
var direction : Vector2
var start_pos : Vector2

var projectile_owner: String

var projectile: CharacterBody2D

func _ready() -> void:
	if get_parent() is CharacterBody2D:
		projectile = get_parent()

func init(in_onwer: String, in_damage: float, in_piercing: float, in_speed: float, in_projectile_range: float):
	projectile_owner = in_onwer
	damage = in_damage
	piercing = in_piercing
	speed = in_speed
	projectile_range = in_projectile_range

func _physics_process(_delta: float) -> void:
	if projectile:
		projectile.velocity = direction.normalized() * speed
		projectile.move_and_slide()
		# Calculate the distance traveled
		var distance_travelled = projectile.global_position.distance_to(start_pos)
		# If the projectile has exceeded the range, free it
		if distance_travelled >= projectile_range:
			projectile.queue_free()

func perform_hit():
	hits += 1
	var spawned_effect = hit_effect.instantiate()
	spawned_effect.global_position = global_position
	get_tree().root.add_child(spawned_effect)
	if hits > piercing:
		get_parent().queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		projectile.queue_free()
