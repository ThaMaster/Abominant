extends Node

signal video_setting_changed(setting: String, value)
signal game_setting_changed(setting: String, value)
signal audio_setting_changed(setting: String, value)

var display_modes: Array = [
	DisplayServer.WINDOW_MODE_WINDOWED,
	DisplayServer.WINDOW_MODE_FULLSCREEN,
	DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
]

var resolutions: Array = [
	Vector2i(1920, 1080),
	Vector2i(1280, 720),
	Vector2i(640, 360)
]

func _ready() -> void:
	if !ConfigFileHandler.init_config():
		set_default_settings()
	else:
		load_config_settings()

func set_default_settings():
	set_display_mode(0)
	set_resolution(1)
	set_camera_shake(true)
	set_mouse_sensitivity(1.0)
	set_audio_level("master_volume", 1.0)
	set_audio_level("music_volume", 1.0)
	set_audio_level("sfx_volume", 1.0)
	set_audio_level("interface_volume", 1.0)

func load_config_settings():
	var video_settings = ConfigFileHandler.load_setting_type("video")
	set_display_mode(video_settings.display_mode)
	set_resolution(video_settings.resolution)
	set_camera_shake(video_settings.camera_shake)
	
	var game_settings = ConfigFileHandler.load_setting_type("game")
	set_mouse_sensitivity(game_settings.mouse_sensitivity)
	
	var audio_settings = ConfigFileHandler.load_setting_type("audio")
	set_audio_level("master_volume", audio_settings.master_volume)
	set_audio_level("music_volume", audio_settings.music_volume)
	set_audio_level("sfx_volume", audio_settings.sfx_volume)
	set_audio_level("interface_volume", audio_settings.interface_volume)

func set_display_mode(index: int):
	DisplayServer.window_set_mode(display_modes[index])
	ConfigFileHandler.save_setting_type("video", "display_mode", index)

func set_resolution(index: int):
	get_window().size = resolutions[index]
	ConfigFileHandler.save_setting_type("video", "resolution", index)

func set_camera_shake(enabled: bool):
	video_setting_changed.emit("camera_shake", enabled)
	ConfigFileHandler.save_setting_type("video", "camera_shake", enabled)

func set_mouse_sensitivity(value: float):
	game_setting_changed.emit("mouse_sensitivity", value)
	ConfigFileHandler.save_setting_type("game", "mouse_sensitivity", value)

func set_audio_level(key: String, value: float):
	audio_setting_changed.emit(key, value)
	ConfigFileHandler.save_setting_type("audio", key, value)

func get_setting(type: String, key: String):
	var settings = ConfigFileHandler.load_setting_type(type)
	return settings.get(key)
