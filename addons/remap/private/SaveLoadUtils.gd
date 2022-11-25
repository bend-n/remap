## Saveing and loading utilities.
## Provides functions to save [InputEventAction]s.

extends RefCounted
const RemapUtilities := preload("./RemapUtilities.gd")

## The directory to put the inputs in.
const dir := "user://__inputs__/"

## The complete path template.
const path_template := dir + "%s.res"


## Saves a basic dictionary to a path.
static func save(path: String, data: Dictionary) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_string(var_to_str(data))


## Loads a basic dictionary out of a file.
static func load_file(path: String) -> Dictionary:
	if FileAccess.file_exists(path):
		var file := FileAccess.open(path, FileAccess.READ)
		var text := file.get_as_text()
		var dict := {}
		if text:
			dict = str_to_var(text)
		return dict
	save(path, {})  # create file if it doesn't exist
	return {}


## Saves a [InputEventAction] to a file.
static func action_to_file(action: String) -> void:
	var list := InputMap.action_get_events(action)
	var data := {actions = list}
	save(path_template % action, data)


## Loads a [InputEventAction] from a file into the [InputMap].
static func load_action_to_inputmap(action: String) -> void:
	var data := load_file(path_template % action)
	if typeof(data) == TYPE_DICTIONARY and typeof(data.get("actions", false)) == TYPE_ARRAY:
		for e in data.actions:  # validate
			if RemapUtilities.is_valid_action(e):
				continue
			push_error("Invalid action: %s" % e)
			action_to_file(action)  # reset if invalid
			return
		RemapUtilities.clear_mappings(action)
		for e in data.actions:
			RemapUtilities.add_action(action, e)
		return
	action_to_file(action)  # reset if invalid
