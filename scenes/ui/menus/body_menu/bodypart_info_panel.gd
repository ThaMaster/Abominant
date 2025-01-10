extends Control
class_name BodypartInfoPanel

# Name Section
@onready var bodypart_label: Label = $MarginContainer/VBoxContainer/NameContainer/MarginContainer/BodypartLabel
@onready var no_selection_label: Label = $MarginContainer/VBoxContainer/NameContainer/MarginContainer/NoSelectionLabel

# Stat Section
@onready var stat_labels_container_left: VBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer/StatsContainer/MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/StatLabelsContainerLeft
@onready var stat_labels_container_right: VBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer/StatsContainer/MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/StatLabelsContainerRight

# Ability Section
@onready var ability_name: Label = $MarginContainer/VBoxContainer/HBoxContainer/AbilityContainer/MarginContainer/VBoxContainer/AbilityName
@onready var ability_text: Label = $MarginContainer/VBoxContainer/HBoxContainer/AbilityContainer/MarginContainer/VBoxContainer/AbilityText
@onready var h_box_container: HBoxContainer = $MarginContainer/VBoxContainer/HBoxContainer

# Info Section
@onready var info_text: Label = $MarginContainer/VBoxContainer/InfoContainer/MarginContainer/VBoxContainer/InfoText
@onready var info_container: PanelContainer = $MarginContainer/VBoxContainer/InfoContainer

# Consume Button
@onready var consume_button: Button = $MarginContainer/VBoxContainer/ConsumeButton

var selected_bodypart: Bodypart
var label_setting: LabelSettings

func _ready() -> void:
	label_setting = LabelSettings.new()
	label_setting.font_size = 10
	GlobalEventManager.body_menu_part_selected.connect(_on_bodypart_selected_event)

func reset_info_panel():
	clear_stat_containers()
	no_selection_label.visible = true
	bodypart_label.visible = false
	h_box_container.visible = false
	info_container.visible = false
	consume_button.visible = false

func init_info_panel(bodypart: Bodypart):
	if not bodypart:
		return
	
	no_selection_label.visible = false
	bodypart_label.text = bodypart.bodypart_name
	bodypart_label.visible = true
	h_box_container.visible = true
	info_container.visible = true
	consume_button.visible = true
	create_stat_labels(bodypart.get_stat_dictionary())

func create_stat_labels(stats: Dictionary):
	clear_stat_containers()
	if not stats:
		return
	
	var set_in_left: bool = true
	for stat in stats:
		var stat_label = Label.new()
		stat_label.name = stat
		stat_label.text = "%s: %d" % [stat.capitalize(), stats[stat]]
		stat_label.label_settings = label_setting
		stat_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		stat_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
		stat_label.label_settings = LabelSettings.new()
		stat_label.label_settings.font_size = 10
		if set_in_left:
			stat_labels_container_left.add_child(stat_label)
		else:
			stat_labels_container_right.add_child(stat_label)
		set_in_left = !set_in_left

func clear_stat_containers():
	for i in range(stat_labels_container_left.get_child_count()):
		stat_labels_container_left.remove_child(stat_labels_container_left.get_child(0))
	for i in range(stat_labels_container_right.get_child_count()):
		stat_labels_container_right.remove_child(stat_labels_container_right.get_child(0))

func _on_bodypart_selected_event(bodypart: Bodypart, _id: int):
	init_info_panel(bodypart)

func _on_consume_button_pressed() -> void:
	pass # Replace with function body.
