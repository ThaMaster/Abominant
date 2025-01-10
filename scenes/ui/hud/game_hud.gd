extends Control
class_name InGameUI 

@onready var ranged_arm_l: RangedArmContainer = $LeftArmPanel/RangedArm
@onready var ranged_arm_r: RangedArmContainer = $RightArmPanel/RangedArm

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

# FIX THIS SHEITY SWITCH THING
func _on_weapon_swtiched_event():
	pass
	#var arm_l : WeaponContainer
	#var arm_r : WeaponContainer
	#if left_ranged_arm_panel.visible:
		#arm_l = left_ranged_arm_panel
		#left_ranged_arm_panel.remove_child(arm_l)
	#if right_ranged_arm_panel.visible:
		#arm_r = right_ranged_arm_panel
		#right_ranged_arm_panel.remove_child(arm_r)
	#if arm_l:
		#right_ranged_arm_panel.add_child(arm_l)
		#arm_l.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
		#arm_l.set_weapon_side(GlobalUtilities.WeaponSide.RIGHT)
	#if arm_r:
		#left_ranged_arm_panel.add_child(arm_r)
		#arm_r.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
		#arm_r.set_weapon_side(GlobalUtilities.WeaponSide.LEFT)
