extends Control
class_name BodypartPanel

@onready var slot_label: Label = $CenterContainer/VBoxContainer/SlotLabel
@onready var empty_label: Label = $CenterContainer/VBoxContainer/EmptyLabel
@onready var bodypart_label: Label = $CenterContainer/VBoxContainer/BodypartLabel
@onready var bodypart_texture: TextureRect = $CenterContainer/VBoxContainer/BodypartTexture
@onready var bodypart_button: Button = $BodypartButton

var bodypart_slot: GlobalUtilities.BodypartSlot
var stored_bodypart: Bodypart
var panel_id: int

func _ready() -> void:
	GlobalEventManager.body_menu_part_selected.connect(_on_bodypart_selected_event)
	GlobalEventManager.bodypart_consumed.connect(_on_bodypart_consumed_event)

func init_bodypart_panel(slot: GlobalUtilities.BodypartSlot, id: int):
	bodypart_slot = slot
	panel_id = id
	slot_label.text = GlobalUtilities.get_bodypart_string(bodypart_slot)
	reset_bodypart_panel()

func set_bodypart(bodypart: Bodypart):
	if not bodypart or bodypart_slot != bodypart.bodypart_slot:
		return
	bodypart_label.text = bodypart.bodypart_name
	bodypart_texture.texture = bodypart.bodypart_image
	stored_bodypart = bodypart
	empty_label.visible = false
	bodypart_label.visible = true
	bodypart_texture.visible = true

func reset_bodypart_panel():
	stored_bodypart = null
	empty_label.visible = true
	bodypart_label.visible = false
	bodypart_texture.visible = false

func _on_bodypart_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		GlobalEventManager.emit_body_menu_part_selected(stored_bodypart, panel_id)

func _on_bodypart_selected_event(_bodypart: Bodypart, id: int):
	if not panel_id == id:
		bodypart_button.button_pressed = false
		return

func _on_bodypart_consumed_event(_bodypart: Bodypart, id: int):
	if panel_id != id:
		return
	reset_bodypart_panel()
