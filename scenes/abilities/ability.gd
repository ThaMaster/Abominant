extends Node2D
class_name Ability

@export var ability_name: String
@export var ability_image: Texture2D
@export var ability_description: String
@export var cooldown_time: float

func perform_ability():
	GlobalUtilities.unimplemented("perform_ability()", get_path())
