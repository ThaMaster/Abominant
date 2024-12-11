extends CharacterBody2D
class_name Bullet

@onready var projectile_component: Node2D = $ProjectileComponent

func get_projectile_component() -> ProjectileComponent:
	return projectile_component

func _physics_process(_delta: float) -> void:
	velocity = projectile_component.direction.normalized() * projectile_component.speed
	move_and_slide()
	# Calculate the distance traveled
	var distance_travelled = global_position.distance_to(projectile_component.start_pos)
	# If the projectile has exceeded the range, free it
	if distance_travelled >= projectile_component.projectile_range:
		queue_free()
