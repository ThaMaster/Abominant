extends Control
class_name BodypartContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var label: Label = $VBoxContainer/Label
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var stat_labels_container: VBoxContainer = $VBoxContainer/StatLabelsContainer
@onready var empty_label: Label = $EmptyLabel

var stored_bodypart: Bodypart
var label_setting: LabelSettings

func _ready() -> void:
	label_setting = LabelSettings.new()
	label_setting.font_size = 10

func init_container(bodypart: Bodypart):
	if not bodypart:
		empty_label.visible = true
		label.visible = false
		texture_rect.visible = false
		return
		
		
	label.text = bodypart.bodypart_name
	if bodypart.bodypart_image:
		texture_rect.texture = bodypart.bodypart_image
	# Create labels for stats dynamically
	create_stat_labels(bodypart.get_stat_dictionary())
	label.visible = true
	texture_rect.visible = true
	empty_label.visible = false
	v_box_container.visible = true
	stored_bodypart = bodypart

func create_stat_labels(stats: Dictionary):
	if not stats:
		return
	for i in range(stat_labels_container.get_child_count()):
		stat_labels_container.remove_child(stat_labels_container.get_child(0))
	
	for stat in stats:
		var stat_label = Label.new()
		stat_label.name = stat
		stat_label.text = "%s: %d" % [stat.capitalize(), stats[stat]]
		stat_label.label_settings = label_setting
		stat_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		stat_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
		stat_label.label_settings = LabelSettings.new()
		stat_labels_container.add_child(stat_label)

func generate_stat_comparison(new_stats: Dictionary):
	if not stored_bodypart:
		return
	
	var current_stats: Dictionary = stored_bodypart.get_stat_dictionary()
	for stat in current_stats:
		var current_value = current_stats.get(stat, 0)
		var new_value = new_stats.get(stat, 0)
		
		var stat_label : Label = stat_labels_container.get_node_or_null(stat)
		if stat_label == null:
			stat_label = Label.new()
			stat_label.name = stat
			stat_label.label_settings = LabelSettings.new()
			stat_labels_container.add_child(stat_label)
		
		# Update text and color
		stat_label.text = "%s: %d → %d" % [stat.capitalize(), current_value, new_value]
		if new_value > current_value:
			stat_label.label_settings.set_font_color(Color(0, 1, 0, 1))   # Green for better
		elif new_value < current_value:
			stat_label.label_settings.set_font_color(Color(1, 0, 0, 1))  # Red for worse
		else:
			stat_label.label_settings.set_font_color(Color(1, 1, 1, 1))  # White for no change
