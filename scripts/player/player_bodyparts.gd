@tool
extends Node2D

#  Dictionary that will contain all the different body parts.
@onready var body_parts = {
	"head": $Head, "body": $Body, "back": $Back, "armL": $ArmL, 
	"armR": $ArmR, "legs": $Legs, "tail": $Tail 
}

# Equips a new a new body part
func set_body_part(part_name: String, scene_path: String):
	if body_parts.has(part_name):
		# Load the new scene
		var new_part = load(scene_path).instantiate()
		queue_free_children(body_parts[part_name])
		body_parts[part_name].add_child(new_part)
	else:
		print("Invalid body part:", part_name)

# For testing
func equip_new_head():
	set_body_part("head", "res://scenes/player/body_parts/heads/head2.tscn")

func _process(_delta: float) -> void:
	# Code that runs only when the game is running
	if not Engine.is_editor_hint():
		handle_mouse()
	# Do this here so it will occurr even outside running the game
	align_body_parts()

func _input(event: InputEvent):
	if event.is_action_pressed("new_head_test"):
		equip_new_head()
	if Input.get_axis("move_left", "move_right"):
		play_animation(body_parts["legs"], "run")
		play_animation(body_parts["tail"], "run")
	else:
		play_animation(body_parts["legs"], "idle")
		play_animation(body_parts["tail"], "idle")
	
	if Input.is_action_just_pressed("attack_left"):
		body_parts["armL"].get_child(0).attack()
	if Input.is_action_just_pressed("attack_right"):
		body_parts["armR"].get_child(0).attack()

func apply_upgrade(strategy: BaseProjectileStrategy):
	body_parts.get("armL").get_child(0).upgrades.append(strategy)

# Function that handles everything regarding the mouse
func handle_mouse():
	var mouse_pos = get_global_mouse_position()
	body_parts["head"].look_at(mouse_pos)
	body_parts["armL"].look_at(mouse_pos)
	body_parts["armR"].look_at(mouse_pos)
	
	# Flip the sprite based on the mouse position relative to the player
	if mouse_pos.x > global_position.x:
		scale.x = 1
	elif mouse_pos.x < global_position.x:
		scale.x = -1

# Aligns all the body parts to corresponding body points
func align_body_parts():
	body_parts["body"].get_child(0).global_position = body_parts["legs"].get_child(0).get_node("BodyPoint").global_position
	body_parts["armL"].get_child(0).global_position = body_parts["body"].get_child(0).get_node("ArmLPoint").global_position
	body_parts["armR"].get_child(0).global_position = body_parts["body"].get_child(0).get_node("ArmRPoint").global_position
	body_parts["head"].get_child(0).global_position = body_parts["body"].get_child(0).get_node("HeadPoint").global_position
	body_parts["tail"].get_child(0).global_position = body_parts["legs"].get_child(0).get_node("TailPoint").global_position

# Plays a specified animation
func play_animation(body_part_node: Node, animation_name: String):
	var animator = (body_part_node.get_child(0).get_node("AnimationPlayer") as AnimationPlayer)
	if animator.has_animation(animation_name):
		animator.play(animation_name)

# Helper function to remove all children from a node
func queue_free_children(node: Node):
	for child in node.get_children():
		child.queue_free()
