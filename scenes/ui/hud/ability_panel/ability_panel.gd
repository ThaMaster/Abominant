extends PanelContainer
class_name AbilityPanel

@onready var ability_containers: HBoxContainer = $MarginContainer/AbilityContainers

func set_ability(ability: ActiveAbility):
	var container: AbilityContainer = ability_containers.get_node("AbilityContainer" + str(ability.ability_slot))
	container.set_ability(ability)

func remove_ability(ability: ActiveAbility):
	var container: AbilityContainer = ability_containers.get_node("AbilityContainer" + str(ability.ability_slot))
	container.remove_ability()
