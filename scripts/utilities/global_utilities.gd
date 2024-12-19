extends Node

enum BodypartSlot {
	HEAD, 
	ARM,
	BACK, 
	TAIL, 
	LEGS
}

enum WeaponSide {
	NONE,
	LEFT,
	RIGHT
}

func get_bodypart_string(selected_slot: BodypartSlot) -> String:
	match selected_slot:
		BodypartSlot.HEAD:
			return "Head"
		BodypartSlot.ARM:
			return "Arm"
		BodypartSlot.BACK:
			return "Back"
		BodypartSlot.TAIL:
			return "Tail"
		BodypartSlot.LEGS:
			return "Legs"
	return "Unknown"  # Fallback if value doesn't match

# Global Random Number Generation
var global_rng = RandomNumberGenerator.new()

func rand_range(min_float: float, max_float : float):
	return global_rng.randf_range(min_float, max_float)

func rand_int_range(min_int: int, max_int: int):
	return global_rng.randi_range(min_int, max_int)

func to_snake_case(input: String) -> String:
	# Replace spaces and special characters with underscores
	var result = input.strip_edges()
	result = result.replace(" ", "_")
	# Convert the string to lowercase
	result = result.to_lower()
	return result

# Used at the end of a function when children of a node must implement it. 
func unimplemented():
	push_error("This method must be implemented by the subclass.")
