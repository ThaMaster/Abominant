extends PanelContainer
class_name AbilityPanel

@onready var ability_containers: HBoxContainer = $MarginContainer/AbilityContainers

func set_ability(ability: ActiveAbility):
	var container: AbilityContainer = ability_containers.get_child(ability.ability_slot-1)
	container.set_ability(ability)
