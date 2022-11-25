## Utilities for remapping.

extends RefCounted


## Clear the mappings for a action.
static func clear_mappings(action: String) -> void:
	InputMap.action_erase_events(action)


## Adds a input to a action.
static func add_action(action: String, event: InputEvent) -> void:
	InputMap.action_add_event(action, event)


## Checks for action validity.
static func is_valid_action(e: InputEvent) -> bool:
	var good_events := [InputEventKey, InputEventMouseButton, InputEventJoypadButton, InputEventJoypadMotion]
	for g_e in good_events:
		if e is g_e:
			return true
	return false
