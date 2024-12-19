extends Control
class_name ComparisonWindow

@onready var title_container: PanelContainer = $TitleContainer
@onready var comparison_window: PanelContainer = $ComparisonWindow

@onready var current_bodypart_container_left: BodypartContainer = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/CurrentContainerLeft/VBoxContainer/CurrentBodypartContainerLeft
@onready var current_bodypart_container_right: BodypartContainer = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/CurrentContainerRight/VBoxContainer/CurrentBodypartContainerRight
@onready var new_bodypart_container: BodypartContainer = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/NewContainer/VBoxContainer/NewBodypartContainer

@onready var equip_right_button: Button = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/CurrentContainerRight/VBoxContainer/EquipRightButton
@onready var equip_left_button: Button = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/CurrentContainerLeft/VBoxContainer/EquipLeftButton
@onready var discard_button: Button = $ComparisonWindow/MarginContainer/VBoxContainer/HBoxContainer/NewContainer/VBoxContainer/DiscardButton

func _ready() -> void:
	title_container.position = comparison_window.position
	title_container.position.x += comparison_window.size.x/2 - title_container.size.x/2
	title_container.position.y -= title_container.size.y/2

func init(bodypart_item: BodypartItem):
	new_bodypart_container.init_container(bodypart_item)
	if bodypart_item.selected_slot == GlobalUtilities.BodypartSlot.ARM:
		current_bodypart_container_right.visible = true
