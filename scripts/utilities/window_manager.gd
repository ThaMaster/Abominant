extends Node

var resolutions: Array = [
	Vector2i(1920, 1080),
	Vector2i(1280, 720),
	Vector2i(640, 360)
]

func _ready() -> void:
	SettingsManager.video_setting_changed.connect(_on_updated_video_settings)

func _on_updated_video_settings(setting: String, value):
	if setting == "display_mode":
		update_display_mode(value)
	elif setting == "resolution":
		update_resolution(value)

func update_display_mode(index: int):
	match index:
		0: # Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: # Borderless Window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		2: # Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		3: # Borderless Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	update_resolution(SettingsManager.get_setting("resolution"))
	ConfigFileHandler.save_setting_type("video", "display_mode", index)

func update_resolution(index):
	DisplayServer.window_set_size(resolutions[index])
	get_window().move_to_center()
