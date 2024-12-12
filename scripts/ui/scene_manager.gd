extends Node
class_name SceneManager

var is_paused: bool = false

@onready var in_game_ui: CanvasLayer = $InGameUI
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var pause_menu: CanvasLayer = $PauseMenu

func _ready() -> void:
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
