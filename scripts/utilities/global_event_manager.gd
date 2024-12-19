extends Node

signal new_bodypart_handled
signal new_bodypart_found(bodypart_item: BodypartItem)

signal weapon_equipped(bodypart: String, type: String, ammo_capacity: int)
signal weapon_switched
signal weapon_fired
signal weapon_reloading(weapon_location: GlobalUtilities.WeaponSide, wait_time: float)
signal weapon_ammo_changed(weapon_location: GlobalUtilities.WeaponSide, current_ammo: int, max_ammo: int)

func emit_new_bodypart_handled():
	new_bodypart_handled.emit()

func emit_new_bodypart_found(bodypart_item: BodypartItem):
	new_bodypart_found.emit(bodypart_item)

func emit_weapon_switched():
	weapon_switched.emit()

func emit_weapon_fired():
	weapon_fired.emit()

func emit_weapon_reloading(weapon_location: GlobalUtilities.WeaponSide, wait_time: float):
	weapon_reloading.emit(weapon_location, wait_time)

func emit_weapon_ammo_changed(weapon_location: GlobalUtilities.WeaponSide, current_ammo: int, max_ammo: int):
	weapon_ammo_changed.emit(weapon_location, current_ammo, max_ammo)
