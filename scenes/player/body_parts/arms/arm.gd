extends Node2D

var upgrades : Array[BaseProjectileStrategy] = []

@onready var ranged_weapon_component: RangedWeaponComponent = $RangedWeaponComponent

func attack():
	ranged_weapon_component.attack(upgrades)
