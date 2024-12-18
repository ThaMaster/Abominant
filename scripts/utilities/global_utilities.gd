extends Node

signal picked_up_loot

# Global Random Number Generation
var global_rng = RandomNumberGenerator.new()

func rand_range(min_float: float, max_float : float):
	return global_rng.randf_range(min_float, max_float)

func rand_int_range(min_int: int, max_int: int):
	return global_rng.randi_range(min_int, max_int)

func emit_loot_pickup(loot: LootItem):
	picked_up_loot.emit(loot)

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
