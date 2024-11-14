extends CharacterBody2D
class_name TestEnemy

func _physics_process(_delta: float) -> void:
	move_and_slide()
	if velocity.length() > 0:
		$AnimationPlayer.play("wander")
	
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
