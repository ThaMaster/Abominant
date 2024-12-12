extends EnemyState
class_name Idle

@export var move_speed : float = 300.0

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func update(delta: float):
	if enemy.get_health_component().has_died:
		transition_to("Dead")
		return
	else:
		if wander_time > 0:
			wander_time -= delta
		else:
			randomize_wander()

func physics_update(_delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	var direction = player.global_position - enemy.global_position
	if direction.length() < 700:
		transition_to("Follow")
