extends Area2D
class_name LootDropComponent

@onready var lootable_effect: GPUParticles2D = $LootableEffect
@onready var loot_label: Label = $LootLabel

@export var loot_chance : float = 0.0
@export var lootable: bool
@export var loot_table : Array[LootItem] = []
@export var entity_sprite : Sprite2D

var dropped_loot : BodypartItem
var looted : bool = false
var player_in_area = false

func _ready() -> void:
	if GlobalUtilities.rand_range(0, 100) < loot_chance:
		dropped_loot = get_drop()
		if dropped_loot:
			lootable = true
		else:
			lootable = false

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("interact"): # Replace with your 'E' input action
		take_loot()

func get_drop() -> LootItem:
	var total_weight = 0
	for item in loot_table:
		total_weight += item.drop_chance
	
	var random_number = GlobalUtilities.rand_range(0, total_weight)
	var cumulative_weight = 0
	
	for loot in loot_table:
		cumulative_weight += loot.drop_chance
		if random_number <= cumulative_weight:
			return loot
	return null # Should not be possible

func take_loot():
	lootable_effect.emitting = false
	looted = true
	GlobalEventManager.emit_new_bodypart_found(dropped_loot)

func _on_body_entered(body: Node2D) -> void:
	if body is Player and lootable:
		player_in_area = true
		loot_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player and lootable:
		player_in_area = false
		loot_label.visible = false
