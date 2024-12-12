extends LootItem
class_name BodypartItem

enum BodypartSlot {
	Head, 
	ArmL,
	ArmR,
	Back, 
	Tail, 
	Legs
}

@export var selected_slot : BodypartSlot

# Function to convert BodypartSlot enum value to string
func get_bodypart_string() -> String:
	match selected_slot:
		BodypartSlot.Head:
			return "Head"
		BodypartSlot.ArmL:
			return "Arm_L"
		BodypartSlot.ArmR:
			return "Arm_R"
		BodypartSlot.Back:
			return "Back"
		BodypartSlot.Tail:
			return "Tail"
		BodypartSlot.Legs:
			return "Legs"
	return "Unknown"  # Fallback if value doesn't match
