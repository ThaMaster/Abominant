extends ActiveAbility
class_name ClusterBomb

const CLUSTER_PROJECTILE = preload("res://scenes/other/projectiles/cluster_projectile/cluster_projectile.tscn")

func perform_ability():
	var start_pos = global_position
	var base_direction = (get_global_mouse_position() - global_position).normalized()
	var projectile: Projectile = CLUSTER_PROJECTILE.instantiate()
	get_tree().root.add_child(projectile)
	var pc = projectile.get_projectile_component()
	
	pc.set_movement_vectors(start_pos, base_direction)
	projectile.global_position = start_pos
	projectile.rotation = base_direction.angle()
