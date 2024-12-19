extends Control

# Video Nodes
@onready var display_mode_options: OptionButton = $SettingsContainer/MarginContainer/VBoxContainer/DisplayModeOptions
@onready var resolution_options: OptionButton = $SettingsContainer/MarginContainer/VBoxContainer/ResolutionOptions
@onready var camera_shake_check: CheckBox = $SettingsContainer/MarginContainer/VBoxContainer/CameraShakeCheck

# Game Nodes
@onready var mouse_sensitivity_slider: HSlider = $SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer5/MouseSensitivitySlider

# Audio Nodes
@onready var master_volume_slider: HSlider = $SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer/MasterVolumeSlider
@onready var music_volume_slider: HSlider = $SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer2/MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = $SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer3/SFXVolumeSlider
@onready var interface_volume_slider: HSlider = $SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer4/InterfaceVolumeSlider
@onready var apply_button: Button = $SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer6/ApplyButton
@onready var default_button: Button = $SettingsContainer/MarginContainer/VBoxContainer/HBoxContainer6/DefaultButton

# Other
@onready var title_container: PanelContainer = $TitleContainer
@onready var settings_container: PanelContainer = $SettingsContainer

func _ready() -> void:
	title_container.position = settings_container.position
	title_container.position.x += settings_container.size.x/2 - title_container.size.x/2
	title_container.position.y -= title_container.size.y/2
	update_setting_interface()

func update_setting_interface():
	display_mode_options.selected = SettingsManager.video_settings.display_mode
	resolution_options.selected = SettingsManager.video_settings.resolution
	camera_shake_check.button_pressed = SettingsManager.video_settings.camera_shake
	
	mouse_sensitivity_slider.value = min(SettingsManager.game_settings.mouse_sensitivity, 1.0) * 100
	
	master_volume_slider.value = min(SettingsManager.audio_settings.master_volume, 1.0) * 100
	music_volume_slider.value = min(SettingsManager.audio_settings.music_volume, 1.0) * 100
	sfx_volume_slider.value = min(SettingsManager.audio_settings.sfx_volume, 1.0) * 100
	interface_volume_slider.value = min(SettingsManager.audio_settings.interface_volume, 1.0) * 100

func _on_display_mode_options_item_selected(index: int) -> void:
	SettingsManager.set_display_mode(index)
	apply_button.disabled = false

func _on_resolution_options_item_selected(index: int) -> void:
	SettingsManager.set_resolution(index)
	apply_button.disabled = false

func _on_camera_shake_check_toggled(toggled_on: bool) -> void:
	SettingsManager.set_camera_shake(toggled_on)
	apply_button.disabled = false

func _on_mouse_sensitivity_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		apply_button.disabled = false
		SettingsManager.set_mouse_sensitivity(mouse_sensitivity_slider.value/100)

func _on_master_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		apply_button.disabled = false
		SettingsManager.set_audio_level("master_volume", master_volume_slider.value/100)

func _on_music_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		apply_button.disabled = false
		SettingsManager.set_audio_level("music_volume", music_volume_slider.value/100)

func _on_sfx_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		apply_button.disabled = false
		SettingsManager.set_audio_level("sfx_volume", sfx_volume_slider.value/100)

func _on_interface_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		apply_button.disabled = false
		SettingsManager.set_audio_level("interface_volume", interface_volume_slider.value/100)

func _on_apply_button_pressed() -> void:
	SettingsManager.apply_all_settings()
	update_setting_interface()
	apply_button.disabled = true

func _on_reset_button_pressed() -> void:
	SettingsManager.set_default_settings()
	SettingsManager.apply_all_settings()
	update_setting_interface()
	apply_button.disabled = true
