extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

func init_config() -> bool:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		return false
	else:
		config.load(SETTINGS_FILE_PATH)
		return true

func save_setting_type(type: String, key: String, value):
	config.set_value(type, key, value)
	config.save(SETTINGS_FILE_PATH)

func load_setting_type(type: String):
	var settings = {}
	for key in config.get_section_keys(type):
		settings[key] = config.get_value(type, key)
	return settings
