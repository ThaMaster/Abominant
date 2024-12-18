extends CanvasLayer

@onready var main: CenterContainer = $main
@onready var settings = $SettingsMenu

func _on_continue_button_pressed() -> void:
	get_parent().toggle_pause()

func _on_settings_button_pressed() -> void:
	main.visible = false
	settings.visible = true

func _on_end_run_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu_scene.tscn")


func _on_back_button_pressed() -> void:
	main.visible = true
	settings.visible = false
