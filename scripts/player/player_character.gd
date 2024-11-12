extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -1000.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# if velocity.x == 0 && velocity.y == 0:
	# if velocity.x != 0:
	# if velocity.y < 0:
	# elif velocity.y > 0:
	# Get the input direction and handle the movement/deceleration: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	# if direction > 0:
	# elif direction < 0:

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
