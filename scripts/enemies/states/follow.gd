class_name Follow extends EnemyState

func enter():
	player = get_tree().get_first_node_in_group("Player")

func physics_update(_delta: float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > 500:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
		
	if direction.length() > 1000:
		transition_to("Idle")
