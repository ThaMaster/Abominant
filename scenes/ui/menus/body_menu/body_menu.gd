extends Control
class_name BodyMenu

@onready var bodyparts : PlayerBodyparts = get_tree().get_nodes_in_group("Player")[0].get_node("PlayerBodyparts")
@onready var body_menu: PanelContainer = $BodyMenu
@onready var title_container: PanelContainer = $TitleContainer

@onready var body_menu_parts: BodyMenuParts = $BodyMenu/MarginContainer/VBoxContainer/MainContainer/BodyMenuParts
@onready var bodypart_info_panel: BodypartInfoPanel = $BodyMenu/MarginContainer/VBoxContainer/MainContainer/BodypartInfoPanel

func _ready() -> void:
	body_menu.resized.connect(adjust_title_container)

func init_body_menu():
	body_menu_parts.init_body_menu_parts(bodyparts)
	bodypart_info_panel.reset_info_panel()

func adjust_title_container():
	title_container.position = body_menu.position
	title_container.position.x += body_menu.size.x/2 - title_container.size.x/2
	title_container.position.y -= title_container.size.y/2
