@tool
class_name StateMachine extends Node

@export var initial_state : State
@export var show_current_state : bool = false
@onready var debugLabel: Label = $"../Debugger-Test"

var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	if show_current_state:
		debugLabel.show()
	else:
		debugLabel.hide()
		
	for state in get_children():
		if state is State:
			states[state.name.to_lower()] = state
			state.Transitioned.connect(on_state_transition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		debugLabel.text = "State: " + current_state.name.to_lower()

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_state_transition(state: State, new_state_name: String):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
	debugLabel.text = "State: " + current_state.name.to_lower()
