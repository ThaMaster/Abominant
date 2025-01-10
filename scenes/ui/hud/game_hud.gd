extends Control
class_name InGameUI 

@onready var left_arm_panel: Control = $LeftArmPanel
@onready var right_arm_panel: Control = $RightArmPanel

@onready var ranged_arm_l: RangedArmContainer = $LeftArmPanel/RangedArmL
@onready var ranged_arm_r: RangedArmContainer = $RightArmPanel/RangedArmR

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEventManager.weapon_switched.connect(_on_weapon_swtiched_event)
	GlobalEventManager.new_bodypart_handled.connect(_on_new_bodypart_handled_event)
	ranged_arm_l.set_weapon_side(GlobalUtilities.WeaponSide.LEFT)
	ranged_arm_r.set_weapon_side(GlobalUtilities.WeaponSide.RIGHT)

func _on_new_bodypart_handled_event(bodypart: Bodypart):
	if not bodypart:
		return
	
	if bodypart.bodypart_slot == GlobalUtilities.BodypartSlot.ARM:
		var texture : TextureRect
		if bodypart.has_node("RangedWeaponComponent"):
			if bodypart.weapon_side == GlobalUtilities.WeaponSide.LEFT:
				ranged_arm_l.weapon_texture.texture = bodypart.bodypart_image
				ranged_arm_l.visible = true
			elif bodypart.weapon_side == GlobalUtilities.WeaponSide.RIGHT:
				ranged_arm_r.weapon_texture.texture = bodypart.bodypart_image
				ranged_arm_r.visible = true
		elif bodypart.has_node("MeleeWeaponComponent"):
			pass

func _on_weapon_swtiched_event():
	var arms_l : Array[Node] = left_arm_panel.get_children()
	var arms_r : Array[Node] = right_arm_panel.get_children()
	
	for node in arms_l:
		left_arm_panel.remove_child(node)
		right_arm_panel.add_child(node)
		node.set_weapon_side(GlobalUtilities.WeaponSide.RIGHT)
	for node in arms_r:
		right_arm_panel.remove_child(node)
		left_arm_panel.add_child(node)
		node.set_weapon_side(GlobalUtilities.WeaponSide.LEFT)
	
