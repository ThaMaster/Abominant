extends CharacterBody2D
class_name Projectile

const hit_effect = preload("res://scenes/hit_effect.tscn")

@export var base_damage : float = 10.0
@export var base_speed : float = 1500.0
@export var projectile_range : float = 3000

var damage : float = base_damage
var speed : float = base_speed

var direction : Vector2
var start_pos : Vector2

func _physics_process(_delta: float) -> void:
	velocity = direction.normalized() * speed
	move_and_slide()
	# Calculate the distance traveled
	var distance_travelled = global_position.distance_to(start_pos)
	# If the projectile has exceeded the range, free it
	if distance_travelled >= projectile_range:
		queue_free()
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body is not Player:
		var spawned_effect = hit_effect.instantiate()
		spawned_effect.global_position = global_position
		get_tree().root.add_child(spawned_effect)
	if body is not Player:
		queue_free()
