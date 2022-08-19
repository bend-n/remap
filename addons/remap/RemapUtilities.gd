extends Reference
class_name RemapUtilities

const invalid_actions = [
	InputEventMouseMotion,
	InputEventJoypadMotion,
	InputEventScreenDrag,
	InputEventScreenTouch,
	InputEventMIDI,
	InputEventMouseButton
]


static func clear_mappings(action: String) -> void:
	InputMap.action_erase_events(action)


static func add_action(action: String, event: InputEvent) -> void:
	InputMap.action_add_event(action, event)


static func is_valid_action(e: InputEvent) -> bool:
	for i in invalid_actions:
		if e is i:
			return false
	return true
