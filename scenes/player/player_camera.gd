extends Camera2D
class_name PlayerCamera

@export var random_strength: float = 30
@export var shake_fade: float = 5.0
@export var mouse_follow_strength: float = 0.5
@export var mouse_follow_max_offset: float = 1000.0

var shake_strength: float = 0.0
var should_shake: bool = false
var camera_shake_enabled: bool = true

var enable_mouse_follow: bool = true

var viewport_size: Vector2
var screen_center: Vector2

var base_offset: Vector2 = Vector2.ZERO
var shake_offset: Vector2 = Vector2.ZERO
var mouse_offset: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_size = get_viewport().get_visible_rect().size
	screen_center = viewport_size / 2
	GlobalEventManager.weapon_fired.connect(_on_weapon_fired_event)
	SettingsManager.video_setting_changed.connect(_on_settings_changed)
	camera_shake_enabled = SettingsManager.get_setting("camera_shake")
	base_offset = offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enable_mouse_follow:
		var mouse_position = get_viewport().get_mouse_position()
		# Calculate the offset from the center
		mouse_offset = (mouse_position - screen_center) * mouse_follow_strength
		# Clamp the offset to the maximum allowed distance
		mouse_offset = mouse_offset.clampf(-mouse_follow_max_offset, mouse_follow_max_offset)
		# Smoothly move the camera towards the target mouse offset
		mouse_offset = lerp(mouse_offset, mouse_offset, 0.1)
	
	if should_shake and camera_shake_enabled:
		apply_shake()
		should_shake = false
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		shake_offset = randomOffset()

	# Combine base offset, mouse-follow offset, and shake offset
	offset = base_offset + mouse_offset + shake_offset

func apply_shake():
	shake_strength = random_strength

func randomOffset() -> Vector2:
	return Vector2(
		GlobalUtilities.rand_range(-shake_strength, shake_strength),
		GlobalUtilities.rand_range(-shake_strength, shake_strength)
	)

func _on_settings_changed(setting: String, value):
	if setting == "camera_shake":
		camera_shake_enabled = value

func _on_weapon_fired_event():
	should_shake = true
