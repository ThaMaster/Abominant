class_name DamageText extends Node2D

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func init_text(dmg_text: String, type: String, is_crit: bool):
	var color: Color
	var brightness_factor : float = 2.0 if is_crit else 1.0
	match type:
		"poison":
			color = Color(0, 0.5 ,0)
		"electric":
			color = Color(0, 0, 0.5)
		"fire":
			color = Color(0.5, 0, 0)
		_:
			color = Color(0.5, 0.5, 0.5)
	label.text = dmg_text
	label.label_settings.font_color = color * brightness_factor

func _on_duration_timeout() -> void:
	queue_free()
