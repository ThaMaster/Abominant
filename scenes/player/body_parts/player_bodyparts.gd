@tool
extends Node2D
class_name PlayerBodyparts

#  Dictionary that will contain all the different body parts.
@onready var bodyparts = {
	"head": $Head, "body": $Body, "back": $Back, "arm_l": $ArmL, 
	"arm_r": $ArmR, "legs": $Legs, "tail": $Tail 
}

@onready var attachment_points = {
	"body": ["legs", "BodyPoint"],
	"arm_l": ["body", "ArmLPoint"],
	"arm_r": ["body", "ArmRPoint"],
	"head": ["body", "HeadPoint"],
	"tail": ["legs", "TailPoint"]
}

# Equips a new a new body part
func set_bodypart(part_name: String, new_part: Bodypart):
	if bodyparts.has(part_name):
		# Load the new scene
		queue_free_children(bodyparts[part_name])
		bodyparts[part_name].add_child(new_part)
	else:
		print("Invalid body part:", part_name)

func get_bodypart(slot: GlobalUtilities.BodypartSlot, side: GlobalUtilities.WeaponSide) -> Bodypart:
	var bodypart_string = GlobalUtilities.get_bodypart_string(slot, side)
	if bodyparts.get(bodypart_string).get_child_count() != 0:
		return bodyparts.get(bodypart_string).get_child(0)
	else:
		return null

func _process(_delta: float) -> void:
	# Code that runs only when the game is running
	if not Engine.is_editor_hint():
		handle_mouse()
	# Do this here so it will occurr even outside running the game
	align_body_parts()

func apply_upgrade(strategy: BaseProjectileStrategy) -> bool:
	# FIX THIS
	if bodyparts.get("arm_l").get_child_count() != 0:
		bodyparts.get("arm_l").get_child(0).upgrades.append(strategy)
		return true
	else:
		return false

func attack(bodypart: String):
	if bodyparts[bodypart].get_child_count() != 0:
		bodyparts[bodypart].get_child(0).attack()

# Function that handles everything regarding the mouse
func handle_mouse():
	var mouse_pos = get_global_mouse_position()
	bodyparts["head"].look_at(mouse_pos)
	bodyparts["arm_l"].look_at(mouse_pos)
	bodyparts["arm_r"].look_at(mouse_pos)
	
	# Flip the sprite based on the mouse position relative to the player
	if mouse_pos.x > global_position.x:
		scale.x = 1
	elif mouse_pos.x < global_position.x:
		scale.x = -1

# Aligns all the body parts to corresponding body points
func align_body_parts():
	# Loop through the mapping and align the body parts
	for key in attachment_points.keys():
		if bodyparts[key].get_child_count() != 0:
			var base_part = bodyparts[attachment_points.get(key)[0]].get_child(0)
			var point_name = attachment_points.get(key)[1]
			var bodypart = bodyparts[key].get_child(0)
			bodypart.global_position = base_part.get_node(point_name).global_position

# Plays a specified animation
func play_animation(body_part: String, animation_name: String):
	var body_part_node: Node2D = bodyparts[body_part]
	if not body_part_node:
		return
	var animator = (body_part_node.get_child(0).get_node("AnimationPlayer") as AnimationPlayer)
	if animator.has_animation(animation_name):
		animator.play(animation_name)

# Helper function to remove all children from a node
func queue_free_children(node: Node):
	for child in node.get_children():
		child.queue_free()

func equip_new_part(bodypart: Bodypart):
	for key: String in bodyparts.keys():
		if key.to_lower() == bodypart.get_bodypart_string().to_lower():
			set_bodypart(key.to_lower(), bodypart)

func switch_arms():
	var arm_l : Bodypart
	var arm_r : Bodypart
	if bodyparts["arm_l"].get_child_count() != 0:
		arm_l = bodyparts["arm_l"].get_child(0)
		bodyparts["arm_l"].remove_child(arm_l)
	if bodyparts["arm_r"].get_child_count() != 0:
		arm_r = bodyparts["arm_r"].get_child(0)
		bodyparts["arm_r"].remove_child(arm_r)
	
	if arm_l:
		bodyparts["arm_r"].add_child(arm_l)
		arm_l.weapon_side = GlobalUtilities.WeaponSide.RIGHT
	if arm_r:
		bodyparts["arm_l"].add_child(arm_r)
		arm_r.weapon_side = GlobalUtilities.WeaponSide.LEFT
	GlobalEventManager.emit_weapon_switched()
