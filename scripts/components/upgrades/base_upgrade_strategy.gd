extends Resource
class_name BaseUpgradeStrategy

@export var texture : Texture2D
@export var upgrade_text : String

# Applies upgrades to the projectile.
func apply_upgrade(_projectile: ProjectileComponent):
	# This is a placeholder that raises an error if not implemented
	# by a subclass.
	GlobalUtilities.unimplemented()

# Function for displaying the stats gained from the strategy in the interface.
func get_buff_dictionary() -> Dictionary:
	# This is a placeholder that raises an error if not implemented
	# by a subclass
	GlobalUtilities.unimplemented()
	return {}
