extends Body
class_name TestBody

func _ready() -> void:
	super()

func get_stat_dictionary() -> Dictionary:
	return get_base_stat_dictionary()
