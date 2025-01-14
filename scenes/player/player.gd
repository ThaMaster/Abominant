extends CharacterBody2D
class_name Player

@onready var player_bodyparts: Node2D = $PlayerBodyparts
@onready var legs: Node2D = $PlayerBodyparts/Legs

@onready var legs_collision_shape: CollisionShape2D = $LegsCollisionShape
@onready var body_collision_shape: CollisionShape2D = $BodyCollisionShape

func _ready() -> void:
	GlobalEventManager.emit_init_game_hud(player_bodyparts.bodyparts)
	GlobalEventManager.bodypart_consumed.connect(_on_bodypart_consumed_event)
	GlobalEventManager.new_bodypart_handled.connect(_on_new_bodypart_handled_event)
	

func _process(_delta: float) -> void:
	if Input.is_action_pressed("attack_left"):
		player_bodyparts.attack("arm_l")
	if Input.is_action_pressed("attack_right"):
		player_bodyparts.attack("arm_r")
	if Input.is_action_just_pressed("switch_arms"):
		player_bodyparts.switch_arms()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var has_legs = legs.get_child_count() != 0
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if has_legs:
			velocity.y = legs.get_child(0).get_jump_velocity()
		else:
			velocity.y = -500
	# Get the input direction and handle the movement/deceleration: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	var speed : float
	if has_legs:
		speed = legs.get_child(0).get_speed()
	else:
		speed = 500
	
	if direction:
		velocity.x = direction * speed
		if has_legs:
			player_bodyparts.play_animation("legs", "run")
			player_bodyparts.play_animation("tail", "run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if has_legs:
			player_bodyparts.play_animation("legs", "idle")
			player_bodyparts.play_animation("tail", "idle")
	move_and_slide()

func apply_upgrade(strategy: BaseProjectileStrategy) -> bool:
	return player_bodyparts.apply_upgrade(strategy)

func get_body_center() -> Vector2:
	return player_bodyparts.get_body_center()

func _on_bodypart_consumed_event(bodypart: Bodypart, _id: int):
	if bodypart.bodypart_slot == GlobalUtilities.BodypartSlot.LEGS:
		body_collision_shape.disabled = false
		legs_collision_shape.disabled = true

func _on_new_bodypart_handled_event(bodypart: Bodypart):
	if bodypart and bodypart.bodypart_slot == GlobalUtilities.BodypartSlot.LEGS:
		global_position.y -= legs_collision_shape.shape.get_rect().size.y
		body_collision_shape.disabled = true
		legs_collision_shape.disabled = false
