extends Reference
class_name RemapUtilities


static func clear_mappings(action: String):
	InputMap.action_erase_events(action)


static func add_action(action: String, event: InputEvent):
	InputMap.action_add_event(action, event)
