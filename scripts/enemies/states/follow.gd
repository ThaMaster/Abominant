extends EnemyState
class_name Follow

@export var move_speed : float = 300.0

func enter():
	player = get_tree().get_first_node_in_group("Player")

func update(_delta: float):
	if enemy.get_health_component().has_died:
		transition_to("Dead")

func physics_update(_delta: float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > 1000:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
		
	if direction.length() > 1000:
		transition_to("Idle")
