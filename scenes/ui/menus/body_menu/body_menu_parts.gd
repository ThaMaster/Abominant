extends Control
class_name BodyMenuParts

const BODYPART_PANEL = preload("res://scenes/ui/menus/body_menu/bodypart_panel.tscn")

@onready var upper: HBoxContainer = $VBoxContainer/MarginContainer/Upper
@onready var middle: HBoxContainer = $VBoxContainer/MarginContainer2/Middle
@onready var bottom: HBoxContainer = $VBoxContainer/MarginContainer3/Bottom

var head_panels: Array[BodypartPanel]
var arm_panels: Array[BodypartPanel]
var back_panels: Array[BodypartPanel]
var tail_panels: Array[BodypartPanel]
var legs_panels: Array[BodypartPanel]

var arm_l_panel: BodypartPanel
var body_panel: BodypartPanel
var arm_r_panel: BodypartPanel

func init_body_menu_parts(bodyparts: PlayerBodyparts):
	var panel_id: int = 0;
	clear_panels()
	arm_l_panel = BODYPART_PANEL.instantiate()
	middle.add_child(arm_l_panel)
	arm_l_panel.init_bodypart_panel(GlobalUtilities.BodypartSlot.ARM, panel_id)
	panel_id += 1
	arm_l_panel.set_bodypart(bodyparts.get_bodypart(GlobalUtilities.BodypartSlot.ARM, GlobalUtilities.WeaponSide.LEFT))
	body_panel = BODYPART_PANEL.instantiate()
	middle.add_child(body_panel)
	body_panel.init_bodypart_panel(GlobalUtilities.BodypartSlot.BODY, panel_id)
	panel_id += 1
	body_panel.set_bodypart(bodyparts.get_bodypart(GlobalUtilities.BodypartSlot.BODY))
	arm_r_panel = BODYPART_PANEL.instantiate()
	middle.add_child(arm_r_panel)
	arm_r_panel.init_bodypart_panel(GlobalUtilities.BodypartSlot.ARM, panel_id)
	panel_id += 1
	arm_r_panel.set_bodypart(bodyparts.get_bodypart(GlobalUtilities.BodypartSlot.ARM, GlobalUtilities.WeaponSide.RIGHT))
	
	var bodypart_panel: BodypartPanel = BODYPART_PANEL.instantiate()
	for slot in bodyparts.get_bodypart(GlobalUtilities.BodypartSlot.BODY).slots:
		bodypart_panel = BODYPART_PANEL.instantiate()
		match slot:
			GlobalUtilities.BodypartSlot.HEAD:
				head_panels.append(bodypart_panel)
				upper.add_child(bodypart_panel)
			GlobalUtilities.BodypartSlot.ARM:
				continue
			GlobalUtilities.BodypartSlot.BACK:
				back_panels.append(bodypart_panel)
				upper.add_child(bodypart_panel)
			GlobalUtilities.BodypartSlot.TAIL:
				tail_panels.append(bodypart_panel)
				bottom.add_child(bodypart_panel)
			GlobalUtilities.BodypartSlot.LEGS:
				legs_panels.append(bodypart_panel)
				bottom.add_child(bodypart_panel)
			_:
				push_error("Error: Unknown bodypart slot when initializing the bodyparts in the body menu.")
		bodypart_panel.init_bodypart_panel(slot, panel_id)
		panel_id += 1
		bodypart_panel.set_bodypart(bodyparts.get_bodypart(slot))

func clear_panels():
	for panel in upper.get_children():
		upper.remove_child(panel)
		panel.queue_free()
	for panel in middle.get_children():
		middle.remove_child(panel)
		panel.queue_free()
	for panel in bottom.get_children():
		bottom.remove_child(panel)
		panel.queue_free()
