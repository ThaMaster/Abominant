extends Node

signal video_setting_changed(setting: String, value)
signal game_setting_changed(setting: String, value)
signal audio_setting_changed(setting: String, value)

var video_settings: Dictionary
var changed_video_settings: Dictionary = {}
var game_settings: Dictionary
var changed_game_settings: Dictionary = {}
var audio_settings: Dictionary
var changed_audio_settings: Dictionary = {}

func _ready() -> void:
	if !ConfigFileHandler.init_config():
		set_default_settings()
	else:
		load_config_settings()
	apply_all_settings()

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
	video_settings = ConfigFileHandler.load_setting_type("video")
	set_display_mode(video_settings.display_mode)
	set_resolution(video_settings.resolution)
	set_camera_shake(video_settings.camera_shake)
	game_settings = ConfigFileHandler.load_setting_type("game")
	set_mouse_sensitivity(game_settings.mouse_sensitivity)
	audio_settings = ConfigFileHandler.load_setting_type("audio")
	set_audio_level("master_volume", audio_settings.master_volume)
	set_audio_level("music_volume", audio_settings.music_volume)
	set_audio_level("sfx_volume", audio_settings.sfx_volume)
	set_audio_level("interface_volume", audio_settings.interface_volume)

func set_display_mode(index: int):
	changed_video_settings["display_mode"] = index

func set_resolution(index: int):
	changed_video_settings["resolution"] = index

func set_camera_shake(enabled: bool):
	changed_video_settings["camera_shake"] = enabled

func set_mouse_sensitivity(value: float):
	changed_game_settings["mouse_sensitivity"] = value

func set_audio_level(key: String, value: float):
	changed_audio_settings[key] = value

func get_setting(key: String):
	if video_settings.has(key):
		return video_settings.get(key)
	elif game_settings.has(key):
		return game_settings.get(key)
	elif audio_settings.has(key):
		return audio_settings.get(key)
	else:
		push_error("Error: Could not fetch setting, does not exist -> ", key)

func apply_all_settings():
	save_setting_dictionary("video", changed_video_settings, video_setting_changed)
	save_setting_dictionary("game", changed_game_settings, game_setting_changed)
	save_setting_dictionary("audio", changed_audio_settings, audio_setting_changed)
	video_settings = ConfigFileHandler.load_setting_type("video")
	game_settings = ConfigFileHandler.load_setting_type("game")
	audio_settings = ConfigFileHandler.load_setting_type("audio")

func save_setting_dictionary(type: String, changed_settings: Dictionary, setting_signal: Signal):
	if !changed_settings.is_empty():
		for key in changed_settings:
			var value = changed_settings.get(key)
			ConfigFileHandler.save_setting_type(type, key, value)
			setting_signal.emit(key, value)
		changed_settings.clear()
