extends Resource
class_name BaseProjectileStrategy 

@export var texture : Texture2D
@export var upgrade_text : String

func apply_upgrade(_projectile: ProjectileComponent):
	# This is a placeholder that raises an error if not implemented
	# by a subclass.
	GlobalUtilities.unimplemented()

func apply_to_hit():
	# This is a placeholder that raises an error if not implemented
	# by a subclass.
	GlobalUtilities.unimplemented()
