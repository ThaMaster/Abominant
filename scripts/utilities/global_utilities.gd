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

# Used at the end of a function when children of a node must implement it. 
func unimplemented():
	push_error("This method must be implemented by the subclass.")
