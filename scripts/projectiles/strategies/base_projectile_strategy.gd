extends Resource
class_name BaseProjectileStrategy

@export var texture : Texture2D = preload("res://assets/sprites/gBot_foot_r.png")
@export var upgrade_text : String = "Speed"

func apply_upgrade(_projectile: Projectile):
	# This is a placeholder that raises an error if not implemented
	# by a subclass.
	_unimplemented()

func apply_to_hit():
	# This is a placeholder that raises an error if not implemented
	# by a subclass.
	_unimplemented()

func _unimplemented():
	push_error("This method must be implemented by the subclass.")
