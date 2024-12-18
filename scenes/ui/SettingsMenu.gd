extends Control

# Video Nodes
@onready var display_mode_options: OptionButton = $MainSettings/SettingsContainer/MarginContainer/VBoxContainer/DisplayModeOptions
@onready var resolution_options: OptionButton = $MainSettings/SettingsContainer/MarginContainer/VBoxContainer/ResolutionOptions
@onready var camera_shake_check: CheckBox = $MainSettings/SettingsContainer/MarginContainer/VBoxContainer/CameraShakeCheck

# Game Nodes
@onready var mouse_sensitivity_slider: HSlider = $MainSettings/SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer5/MouseSensitivitySlider

# Audio Nodes
@onready var master_volume_slider: HSlider = $MainSettings/SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer/MasterVolumeSlider
@onready var music_volume_slider: HSlider = $MainSettings/SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer2/MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = $MainSettings/SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer3/SFXVolumeSlider
@onready var interface_volume_slider: HSlider = $MainSettings/SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer4/InterfaceVolumeSlider

func _ready() -> void:
	var video_settings = ConfigFileHandler.load_setting_type("video")
	display_mode_options.selected = video_settings.display_mode
	resolution_options.selected = video_settings.resolution
	camera_shake_check.button_pressed = video_settings.camera_shake
	
	var game_settings = ConfigFileHandler.load_setting_type("game")
	mouse_sensitivity_slider.value = min(game_settings.mouse_sensitivity, 1.0) * 100
	
	var audio_settings = ConfigFileHandler.load_setting_type("audio")
	master_volume_slider.value = min(audio_settings.master_volume, 1.0) * 100
	music_volume_slider.value = min(audio_settings.music_volume, 1.0) * 100
	sfx_volume_slider.value = min(audio_settings.sfx_volume, 1.0) * 100
	interface_volume_slider.value = min(audio_settings.interface_volume, 1.0) * 100

func _on_display_mode_options_item_selected(index: int) -> void:
	SettingsManager.set_display_mode(index)

func _on_resolution_options_item_selected(index: int) -> void:
	SettingsManager.set_resolution(index)

func _on_camera_shake_check_toggled(toggled_on: bool) -> void:
	SettingsManager.set_camera_shake(toggled_on)

func _on_master_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_setting_type("audio", "master_volume", master_volume_slider.value/100)

func _on_music_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_setting_type("audio", "music_volume", music_volume_slider.value/100)

func _on_sfx_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_setting_type("audio", "sfx_volume", sfx_volume_slider.value/100)

func _on_interface_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_setting_type("audio", "interface_volume", interface_volume_slider.value/100)
		
func _on_mouse_sensitivity_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_setting_type("game", "mouse_sensitivity", mouse_sensitivity_slider.value/100)
