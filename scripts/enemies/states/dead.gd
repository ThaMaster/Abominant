class_name Dead extends EnemyState

var move_direction : Vector2
var velocity : Vector2
var gravity : Vector2 = Vector2(0, 800)  # You can adjust this value depending on how fast you want the enemy to fall

func enter():
	# Initialize velocity for falling
	enemy.velocity = Vector2.ZERO

func physics_update(delta: float):
	# Update position
	enemy.velocity += gravity * delta

	# Check for collision with the ground (assuming the enemy has a CollisionShape2D)
	if enemy.is_on_floor():  # Adjust this logic to match your ground detection
		# Once the enemy hits the ground, slow down and disappear
		velocity = Vector2.ZERO  # Stop the movement
		get_parent().get_parent().queue_free()
