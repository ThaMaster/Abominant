@tool
extends Control

@onready var title_container: PanelContainer = $TitleContainer
@onready var settings_container: PanelContainer = $SettingsContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title_container.position = settings_container.position
	title_container.position.x += settings_container.size.x/2 - title_container.size.x/2
	title_container.position.y -= title_container.size.y/2
