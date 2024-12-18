extends Node

signal weapon_equipped(body_part: String, type: String, ammo_capacity: int)
signal weapon_switched
signal weapon_fired
signal weapon_reloading(body_part: String, wait_time: float)
signal weapon_reloaded
signal weapon_ammo_changed(current_ammo: int, max_ammo: int)

func emit_weapon_switched():
	weapon_switched.emit()

func emit_weapon_fired():
	weapon_fired.emit()

func emit_weapon_reloading(body_part: String, wait_time: float):
	weapon_reloading.emit(body_part, wait_time)

func emit_weapon_reloaded():
	weapon_reloaded.emit()

func emit_weapon_ammo_changed(current_ammo: int, max_ammo: int):
	weapon_ammo_changed.emit(current_ammo, max_ammo)
