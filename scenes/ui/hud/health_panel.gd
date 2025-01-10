extends PanelContainer
class_name HealthPanel 

@onready var texture_progress_bar: TextureProgressBar = $VBoxContainer/TextureProgressBar
@onready var label: Label = $VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEventManager.player_health_changed.connect(_on_player_health_changed_event)

func _on_player_health_changed_event(current_health: float, max_health: float):
	texture_progress_bar.set_max(max_health)
	texture_progress_bar.set_value(current_health)
	label.text = "Health: " + str(current_health) + "/" + str(max_health)
