extends CanvasLayer
class_name InGameUI 

@onready var left_arm_panel: PanelContainer = $LeftArmPanel
@onready var right_arm_panel: PanelContainer = $RightArmPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEventManager.weapon_switched.connect(_on_weapon_swtiched_event)

func _on_weapon_swtiched_event():
	var arm_l
	var arm_r
	if left_arm_panel.get_child_count() != 0:
		arm_l = left_arm_panel.get_child(0)
		left_arm_panel.remove_child(arm_l)
	if right_arm_panel.get_child_count() != 0:
		arm_r = right_arm_panel.get_child(0)
		right_arm_panel.remove_child(arm_r)
	if arm_l:
		right_arm_panel.add_child(arm_l)
	if arm_r:
		left_arm_panel.add_child(arm_r)
