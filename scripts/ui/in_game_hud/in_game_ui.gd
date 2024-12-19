extends Control
class_name InGameUI 

@onready var left_arm_panel: Control = $LeftArmPanel
@onready var right_arm_panel: Control = $RightArmPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEventManager.weapon_switched.connect(_on_weapon_swtiched_event)

func _on_weapon_swtiched_event():
	var arm_l : WeaponContainer
	var arm_r : WeaponContainer
	if left_arm_panel.get_child_count() != 0:
		arm_l = left_arm_panel.get_child(0)
		left_arm_panel.remove_child(arm_l)
	if right_arm_panel.get_child_count() != 0:
		arm_r = right_arm_panel.get_child(0)
		right_arm_panel.remove_child(arm_r)
	if arm_l:
		right_arm_panel.add_child(arm_l)
		arm_l.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
		arm_l.set_weapon_side(GlobalUtilities.WeaponSide.RIGHT)
	if arm_r:
		left_arm_panel.add_child(arm_r)
		arm_r.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
		arm_r.set_weapon_side(GlobalUtilities.WeaponSide.LEFT)
