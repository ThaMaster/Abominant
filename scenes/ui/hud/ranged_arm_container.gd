extends WeaponContainer
class_name RangedArmContainer

@onready var ammo_bar: TextureProgressBar = $HBoxContainer/AmmoBar
@onready var cooldown_bar: TextureProgressBar = $CooldownBar
@onready var weapon_texture: TextureRect = $HBoxContainer/WeaponTexture

var is_reloading: bool = false

func _ready() -> void:
	GlobalEventManager.weapon_reloading.connect(_on_weapon_reloading_event)
	GlobalEventManager.weapon_ammo_changed.connect(_on_weapon_ammo_changed_event)

func update_ammo(max_ammo: int, current_ammo: int):
	ammo_bar.max_value = max_ammo
	ammo_bar.value = current_ammo

func start_reload(reload_duration: float):
	is_reloading = true
	cooldown_bar.max_value = reload_duration
	cooldown_bar.value = reload_duration
	cooldown_bar.visible = true

func _process(delta):
	if is_reloading:
		cooldown_bar.value -= delta
		if cooldown_bar.value <= 0:
			is_reloading = false
			cooldown_bar.visible = false

func _on_weapon_reloading_event(side: GlobalUtilities.WeaponSide, reload_time: float):
	if side == weapon_side:
		start_reload(reload_time)

func _on_weapon_ammo_changed_event(side: GlobalUtilities.WeaponSide, current_ammo: int, ammo_capacity: int):
	if side == weapon_side:
		ammo_bar.max_value = ammo_capacity
		ammo_bar.value = current_ammo
