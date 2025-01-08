extends Node
class_name UIManager

var is_paused: bool = false

@onready var in_game_ui: InGameUI = $CanvasLayer/InGameUI
@onready var canvas_modulate: CanvasModulate = $CanvasLayer/CanvasModulate
@onready var pause_menu: PauseMenu = $CanvasLayer/CanvasLayer/PauseMenu
@onready var comparison_window: ComparisonWindow = $CanvasLayer/CanvasLayer/ComparisonWindow

func _ready() -> void:
	GlobalEventManager.new_bodypart_found.connect(_on_new_bodypart_found_event)
	GlobalEventManager.new_bodypart_handled.connect(_on_new_bodypart_handled_event)
	
	# Initialize: pause menu hidden and no dimming
	pause_menu.visible = false
	canvas_modulate.color = Color(1, 1, 1, 1)  # No dimming (default white color)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_pause_menu"):
		toggle_pause()

func toggle_pause():
	is_paused = not is_paused
	get_tree().paused = is_paused
	pause_menu.visible = is_paused
	in_game_ui.visible = !is_paused
	# Adjust the dimming effect with CanvasModulate
	if is_paused:
		canvas_modulate.color = Color(0.5, 0.5, 0.5, 1.0)  # Dim the scene by 50%
	else:
		canvas_modulate.color = Color(1, 1, 1, 1)  # Restore full brightness

func _on_new_bodypart_found_event(bodypart: Bodypart):
	canvas_modulate.color = Color(0.5, 0.5, 0.5, 1.0)
	comparison_window.init(bodypart)
	comparison_window.visible = true

func _on_new_bodypart_handled_event(_bodypart: Bodypart):
	canvas_modulate.color = Color(1, 1, 1, 1)
	comparison_window.visible = false
