extends Ability
class_name ActiveAbility

var ability_slot: int = 1

func _ready() -> void:
	GlobalEventManager.ability_activated.connect(_on_ability_activated_event)

# When an ability activated event comes in, check if slots are the same.
# If they are not, it was a different ability that was activated.
func _on_ability_activated_event(slot: int):
	if ability_slot != slot:
		return
	perform_ability()
