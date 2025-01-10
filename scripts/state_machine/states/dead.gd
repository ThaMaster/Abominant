extends EnemyState
class_name Dead

@onready var timer: Timer = $Timer
@export var removal_delay : float = 1.0

var move_direction : Vector2
var velocity : Vector2
var gravity : Vector2 = Vector2(0, 800)  # You can adjust this value depending on how fast you want the enemy to fall

func enter():
	timer.wait_time = removal_delay
	enemy.get_hurtbox_component().disabled = true
	# Initialize velocity for falling
	enemy.velocity = Vector2.ZERO

func update(_delta: float):
	if enemy.get_loot_drop_component().looted:
		start_timer()

func physics_update(delta: float):
	# Update position
	enemy.velocity += gravity * delta
	# Check for collision with the ground (assuming the enemy has a CollisionShape2D)
	if enemy.is_on_floor():  # Adjust this logic to match your ground detection
		# Once the enemy hits the ground, slow down and disappear
		velocity = Vector2.ZERO  # Stop the movement
		if not enemy.get_loot_drop_component().lootable:
			start_timer()
		elif not enemy.get_loot_drop_component().looted:
			enemy.get_loot_drop_component().lootable_effect.emitting = true

func _on_timer_timeout() -> void:
	enemy.queue_free()

func start_timer():
	if not timer.time_left > 0:
		timer.start()
