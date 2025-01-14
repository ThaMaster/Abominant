extends Node

# Ability signals
signal ability_activated(ability_slot: int)

# Bodypart signals
signal new_bodypart_handled(bodypart: Bodypart)
signal new_bodypart_found(bodypart: Bodypart)

# Health signals
signal player_health_changed(current_health: float, max_health: float)
signal player_health_depleted

# Arm signals
signal weapon_switched

# Ranged arm signals
signal weapon_fired
signal weapon_reloading(weapon_location: GlobalUtilities.WeaponSide, wait_time: float)
signal weapon_ammo_changed(weapon_location: GlobalUtilities.WeaponSide, current_ammo: int, max_ammo: int)

# GUI signals
signal init_game_hud(bodyparts: Dictionary)
signal body_menu_part_selected(bodypart: Bodypart, id: int)
signal bodypart_consumed(bodypart: Bodypart, id: int)

func emit_ability_activated(ability_slot: int):
	ability_activated.emit(ability_slot)

func emit_new_bodypart_handled(bodypart: Bodypart):
	bodypart.visible = true
	new_bodypart_handled.emit(bodypart)

func emit_new_bodypart_found(bodypart: Bodypart):
	bodypart.visible = false
	new_bodypart_found.emit(bodypart)

func emit_player_health_changed(current_health: float, max_health: float):
	player_health_changed.emit(current_health, max_health)

func emit_player_health_depleted():
	player_health_depleted.emit()

func emit_weapon_switched():
	weapon_switched.emit()

func emit_weapon_fired():
	weapon_fired.emit()

func emit_weapon_reloading(weapon_location: GlobalUtilities.WeaponSide, wait_time: float):
	weapon_reloading.emit(weapon_location, wait_time)

func emit_weapon_ammo_changed(weapon_location: GlobalUtilities.WeaponSide, current_ammo: int, max_ammo: int):
	weapon_ammo_changed.emit(weapon_location, current_ammo, max_ammo)

func emit_init_game_hud(bodyparts: Dictionary):
	init_game_hud.emit(bodyparts)

func emit_body_menu_part_selected(bodypart: Bodypart, id: int):
	body_menu_part_selected.emit(bodypart, id)

func emit_bodypart_consumed(bodypart: Bodypart, id: int):
	bodypart_consumed.emit(bodypart, id)
