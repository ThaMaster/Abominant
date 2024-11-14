extends Node2D

var upgrades : Array[BaseProjectileStrategy] = []

const bullet_scene = preload("res://scripts/projectiles/bullet.tscn")

func attack():
	var spawned_bullet = bullet_scene.instantiate()
	var mouse_direction = get_global_mouse_position() - self.global_position
	
	get_tree().root.add_child(spawned_bullet)
	spawned_bullet.global_position = self.global_position
	spawned_bullet.start_pos = self.global_position
	spawned_bullet.rotation = mouse_direction.angle()
	spawned_bullet.direction = mouse_direction
	
	for strategy in upgrades:
		strategy.apply_upgrade(spawned_bullet)
