extends CharacterBody2D
class_name Player

@onready var legs: Node2D = $PlayerBodyParts/Legs

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if legs.get_child(0).has_method("get_jump_velocity"):
			velocity.y = legs.get_child(0).get_jump_velocity()
		else:
			print("Error: Leg node does not have the 'get_jump_velocity' method!")
	
	# Get the input direction and handle the movement/deceleration: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	var speed : float
	if legs.get_child(0).has_method("get_speed"):
		speed = legs.get_child(0).get_speed()
	else:
		print("Error: Leg node does not have the 'get_speed' method!")

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()

func apply_upgrade(strategy: BaseProjectileStrategy) -> bool:
	return get_node("PlayerBodyParts").apply_upgrade(strategy)
