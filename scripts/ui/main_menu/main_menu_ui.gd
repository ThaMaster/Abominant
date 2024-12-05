extends CanvasLayer

@onready var main: CenterContainer = $main
@onready var settings: CenterContainer = $settings

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/other/main.tscn")

func _on_settings_button_pressed() -> void:
	main.visible = false
	settings.visible = true
	
	
func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_settings_back_button_pressed() -> void:
	main.visible = true
	settings.visible = false
