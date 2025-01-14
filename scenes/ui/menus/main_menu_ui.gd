extends CanvasLayer
class_name MainMenuUI 

@onready var main = $MainMenu
@onready var settings = $SettingsMenu

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/floors/main.tscn")

func _on_settings_button_pressed() -> void:
	main.visible = false
	settings.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_back_button_pressed() -> void:
	main.visible = true
	settings.visible = false
