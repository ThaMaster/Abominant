class_name TestEnemy extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent

func _process(_delta: float) -> void:
	if health_component.has_died:
		queue_free()

func _physics_process(_delta: float) -> void:
	move_and_slide()
	if velocity.length() > 0:
		$AnimationPlayer.play("wander")
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
