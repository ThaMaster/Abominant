extends CharacterBody2D
class_name TestEnemy 

@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var loot_drop_component: LootDropComponent = $LootDropComponent

func _physics_process(_delta: float) -> void:
	move_and_slide()
	if velocity.length() > 0:
		$AnimationPlayer.play("wander")
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

func get_health_component() -> HealthComponent:
	return health_component

func get_hurtbox_component() -> HurtboxComponent:
	return hurtbox_component

func get_loot_drop_component() -> LootDropComponent:
	return loot_drop_component
