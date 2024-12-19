extends BaseProjectileStrategy
class_name ParticleProjectileStrategy

var particle_scene : PackedScene = preload("res://scripts/components/upgrades/projectile_strategies/particles/bullet_particles.tscn")

func apply_upgrade(projectile : ProjectileComponent):
	var spawned_particles : Node2D = particle_scene.instantiate()
	projectile.add_child(spawned_particles)
	spawned_particles.global_position = projectile.global_position

# Function for displaying the stats gained from the strategy in the interface.
func get_buff_dictionary() -> Dictionary:
	var buffs: Dictionary
	buffs["particles"] = 1
	return buffs
