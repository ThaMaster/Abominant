extends Node2D

@export var flip_body_part = false

#  Dictionary that will contain all the different body parts.
@onready var body_parts = {
	"head": $Head,
	"body": $Body,
	"back": $Back,
	"armL": $ArmL,
	"armR": $ArmR,
	"legs": $Legs,
	"tail": $Tail
}

func set_body_part(part_name: String, scene_path: String):
	if body_parts.has(part_name):
		# Load the new scene
		var new_part = load(scene_path).instantiate()
		queue_free_children(body_parts[part_name])
		body_parts[part_name].add_child(new_part)
	else:
		print("Invalid body part:", part_name)

# Helper function to remove all children from a node
func queue_free_children(node: Node):
	for child in node.get_children():
		child.queue_free()

func equip_new_head():
	set_body_part("head", "res://scenes/player/body_parts/heads/head2.tscn")

func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	body_parts["head"].look_at(mouse_pos)
	body_parts["armL"].look_at(mouse_pos)
	body_parts["armR"].look_at(mouse_pos)
	
	# Flip the sprite based on the mouse position relative to the player
	if mouse_pos.x > global_position.x:
		set_flip(true)
	elif mouse_pos.x < global_position.x:
		set_flip(false)
	
	body_parts["body"].get_child(0).global_position = body_parts["legs"].get_child(0).get_node("BodyPoint").global_position
	body_parts["armL"].get_child(0).global_position = body_parts["body"].get_child(0).get_node("ArmLPoint").global_position
	body_parts["armR"].get_child(0).global_position = body_parts["body"].get_child(0).get_node("ArmRPoint").global_position
	body_parts["head"].get_child(0).global_position = body_parts["body"].get_child(0).get_node("HeadPoint").global_position
	

func _input(event: InputEvent):
	if event.is_action_pressed("new_head_test"):
		equip_new_head()
	if Input.get_axis("move_left", "move_right"):
		body_parts["legs"].get_child(0).get_node("AnimationPlayer").play("run")
	else:
		body_parts["legs"].get_child(0).get_node("AnimationPlayer").play("idle")


# Set method for flip_h
func set_flip(value: bool) -> void:
	if flip_body_part != value:
		flip_body_part = value
		update_flip()

# Update the flip based on the flip_h variable
func update_flip() -> void:
	self.set_scale(Vector2(1 if flip_body_part else -1, 1))
	#for child in get_children():
	#	var body_part = child.get_child(0)
	#	if body_part != null:
	#		scale.x = 1 if flip_body_part else 1

func flip_bones():
	#get_node("Container/Bones/Skeleton2D").scale.x = 1 if flip_body_part else -1
	pass
