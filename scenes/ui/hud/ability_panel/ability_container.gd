extends PanelContainer
class_name AbilityContainer

@export var ability_slot: int

@onready var ability_button: Button = $AbilityButton
@onready var texture_rect: TextureRect = $CenterContainer/TextureRect
@onready var shortcut_label: Label = $CenterContainer/ShortcutLabel
@onready var cooldown_label: Label = $CenterContainer/CooldownLabel

@onready var darken_material: ShaderMaterial = ShaderMaterial.new()
const DARKEN_MATERIAL = preload("res://assets/shaders/darken_material.gdshader")

var cooldown_remaining: float = 0.0
var cooldown_total: float = 0.0

func _ready() -> void:
	shortcut_label.text = str(ability_slot)
	ability_button.set_shortcut(create_shortcut())
	ability_button.disabled = true
	
	# Load the shader and set it to the TextureRect
	darken_material.shader = DARKEN_MATERIAL
	texture_rect.material = darken_material

func set_ability(ability: ActiveAbility):
	texture_rect.set_texture(ability.ability_image)
	cooldown_total = ability.cooldown_time
	ability_button.disabled = false

func remove_ability():
	ability_button.disabled = false
	texture_rect.set_texture(null)

func create_shortcut() -> Shortcut:
	var shortcut: Shortcut = Shortcut.new()
	var input_event: Array[InputEvent] = InputMap.action_get_events("ability_" + str(ability_slot))
	shortcut.set_events(input_event)
	return shortcut

func _on_ability_button_pressed() -> void:
	if cooldown_remaining <= 0:
		GlobalEventManager.emit_ability_activated(ability_slot)
		start_cooldown()

func _process(delta: float) -> void:
	if cooldown_remaining > 0:
		cooldown_remaining -= delta
		cooldown_label.text = str(ceil(cooldown_remaining)) + "s"
		if cooldown_remaining <= 0:
			cooldown_remaining = 0
			cooldown_complete()

func start_cooldown():
	cooldown_remaining = cooldown_total
	ability_button.disabled = true
	darken_material.set_shader_parameter("darken_factor", 0.3)  # Darken by 70%
	shortcut_label.modulate = Color(0.3, 0.3, 0.3)
	cooldown_label.visible = true

func cooldown_complete():
	ability_button.disabled = false
	darken_material.set_shader_parameter("darken_factor", 1.0)  # Restore original brightness
	shortcut_label.modulate = Color(1.0, 1.0, 1.0)
	cooldown_label.visible = false
