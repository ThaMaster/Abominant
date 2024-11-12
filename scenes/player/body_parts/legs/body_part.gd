extends Node2D

@export var flip_body_part = false

# Set method for flip_h
func set_flip(value: bool) -> void:
	if flip_body_part != value:
		flip_body_part = value
		update_flip()

# Update the flip based on the flip_h variable
func update_flip() -> void:
	flip_sprites(get_node("Container/Sprites").get_children())
	flip_bones()

# Flips the sprites of the body part
func flip_sprites(nodes: Array[Node]):
	for node in nodes:
		# If the node is a sprite, flip it
		if node is Sprite2D:
			(node as Sprite2D).flip_h = !flip_body_part
		else:
			# If the node is not a sprite, it is a node with multiple sprites
			flip_sprites(node.get_children())

func flip_bones():
	get_node("Container/Bones/Skeleton2D").scale.x = 1 if flip_body_part else -1
	
