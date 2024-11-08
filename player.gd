extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if velocity.x == 0 && velocity.y == 0:
		animated_sprite_2d.play("default")
		
	if velocity.x != 0:
		animated_sprite_2d.play("run")
		if velocity.x > 0:
			animated_sprite_2d.flip_h = false
		if velocity.x < 0:
			animated_sprite_2d.flip_h = true
	
	if velocity.y < 0:
		animated_sprite_2d.play("jump_up")
	elif velocity.y > 0:
		animated_sprite_2d.play("jump_down")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
