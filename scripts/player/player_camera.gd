extends Camera2D

@export var random_strength: float = 30
@export var shake_fade: float = 5.0

var base_offset: Vector2
var shake_strength: float = 0.0

var camera_shake_enabled: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SettingsManager.video_setting_changed.connect(_on_settings_changed)
	camera_shake_enabled = SettingsManager.get_setting("camera_shake")
	base_offset = offset

func apply_shake():
	shake_strength = random_strength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("attack_left") and camera_shake_enabled:
		apply_shake()
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = base_offset + randomOffset()

func randomOffset() -> Vector2:
	return Vector2(GlobalUtilities.rand_range(-shake_strength, shake_strength), GlobalUtilities.rand_range(-shake_strength, shake_strength))

func _on_settings_changed(setting: String, value):
	if setting == "camera_shake":
		camera_shake_enabled = value
