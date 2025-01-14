extends GPUParticles2D
class_name ExplosionEffect

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
