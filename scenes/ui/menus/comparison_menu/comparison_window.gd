extends Control
class_name ComparisonWindow

@onready var bodyparts : PlayerBodyparts = get_tree().get_nodes_in_group("Player")[0].get_node("PlayerBodyparts")

@onready var title_container: PanelContainer = $TitleContainer
@onready var comparison_window: PanelContainer = $ComparisonWindow

@onready var current_bodypart_container_left: BodypartContainer = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/CurrentContainerLeft/VBoxContainer/CurrentBodypartContainerLeft
@onready var current_bodypart_container_right: BodypartContainer = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/CurrentContainerRight/VBoxContainer/CurrentBodypartContainerRight
@onready var new_bodypart_container: BodypartContainer = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/NewContainer/VBoxContainer/NewBodypartContainer

@onready var equip_right_button: Button = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/CurrentContainerRight/VBoxContainer/EquipRightButton
@onready var equip_left_button: Button = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/CurrentContainerLeft/VBoxContainer/EquipLeftButton
@onready var discard_button: Button = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/NewContainer/VBoxContainer/DiscardButton

var new_slot : GlobalUtilities.BodypartSlot

func _ready() -> void:
	comparison_window.resized.connect(adjust_title_container)

func init(bodypart: Bodypart):
	print("Before: ", comparison_window.size.y)
	new_slot = bodypart.bodypart_slot
	new_bodypart_container.init_container(bodypart)
	if new_slot == GlobalUtilities.BodypartSlot.ARM:
		current_bodypart_container_right.visible = true
		current_bodypart_container_left.init_container(bodyparts.get_bodypart(new_slot, GlobalUtilities.WeaponSide.LEFT))
		current_bodypart_container_left.generate_stat_comparison(bodypart.get_stat_dictionary())
		current_bodypart_container_right.init_container(bodyparts.get_bodypart(new_slot, GlobalUtilities.WeaponSide.RIGHT))
		current_bodypart_container_right.generate_stat_comparison(bodypart.get_stat_dictionary())
	else:
		current_bodypart_container_right.visible = false
		current_bodypart_container_right.init_container(bodyparts.get_bodypart(new_slot, GlobalUtilities.WeaponSide.NONE))
		current_bodypart_container_right.generate_stat_comparison(bodypart.get_stat_dictionary())

func _on_equip_left_button_pressed() -> void:
	var new_bodypart : Bodypart = new_bodypart_container.stored_bodypart
	new_bodypart.set_weapon_side(GlobalUtilities.WeaponSide.LEFT)
	var bodypart_string = GlobalUtilities.get_bodypart_string(new_slot, new_bodypart.weapon_side)
	new_bodypart.get_parent().remove_child(new_bodypart)
	bodyparts.set_bodypart(bodypart_string, new_bodypart)
	visible = false
	GlobalEventManager.emit_new_bodypart_handled(new_bodypart)

func _on_equip_right_button_pressed() -> void:
	var new_bodypart = new_bodypart_container.stored_bodypart
	new_bodypart.set_weapon_side(GlobalUtilities.WeaponSide.RIGHT)
	var bodypart_string = GlobalUtilities.get_bodypart_string(new_slot, new_bodypart.weapon_side)
	new_bodypart.get_parent().remove_child(new_bodypart)
	bodyparts.set_bodypart(bodypart_string, new_bodypart)
	visible = false
	GlobalEventManager.emit_new_bodypart_handled(new_bodypart)

func _on_discard_button_pressed() -> void:
	var new_bodypart = new_bodypart_container.stored_bodypart
	new_bodypart.get_parent().remove_child(new_bodypart)
	visible = false
	GlobalEventManager.emit_new_bodypart_handled(null)

func adjust_title_container():
	title_container.position = comparison_window.position
	title_container.position.x += comparison_window.size.x/2 - title_container.size.x/2
	title_container.position.y -= title_container.size.y/2
