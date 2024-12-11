extends PanelContainer

@onready var ammo_bar: TextureProgressBar = $MarginContainer/HBoxContainer/AmmoBar
@onready var cooldown_bar: TextureProgressBar = $MarginContainer/HBoxContainer/WeaponTexture/CooldownBar
@onready var weapon_texture: TextureRect = $MarginContainer/HBoxContainer/WeaponTexture

var reload_duration : float = 0.0
var reload_time_left : float = 0.0

func update_ammo(max_ammo: int, current_ammo: int):
	ammo_bar.max_value = max_ammo
	ammo_bar.value = current_ammo

func start_cooldown():
	reload_time_left = reload_duration
	cooldown_bar.max_value = reload_duration
	cooldown_bar.value = reload_duration
	cooldown_bar.visible = true
	weapon_texture.modulate = Color(0.5, 0.5, 0.5, 1.0)  # Dim the texture (50% brightness)

func _process(delta: float):
	if reload_time_left > 0:
		reload_time_left -= delta
		cooldown_bar.value = reload_time_left  # Update the bar value
		if reload_time_left <= 0:
			reload_time_left = 0
			cooldown_bar.visible = false
			weapon_texture.modulate = Color(1.0, 1.0, 1.0, 1.0)  # Reset to full brightness
