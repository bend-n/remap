#warning-ignore-all: return_value_discarded
extends Node
class_name SaveLoadUtils

const dir := "user://__inputs__"
const path_template := "user://__inputs__/%s.res"


static func save(path: String, data: Dictionary) -> void:
	var file := File.new()
	file.open(path, File.WRITE)
	file.store_string(var2str(data))
	file.close()


static func load_file(path: String) -> Dictionary:
	var file := File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var text := file.get_as_text()
		var dict := {}
		if text:
			dict = str2var(text)
		file.close()
		return dict
	save(path, {})  # create file if it doesn't exist
	return {}


# mkdir -p
static func create_dir(path: String) -> int:
	var dir := Directory.new()
	return dir.make_dir_recursive(path)


static func inputmap2file(action: String) -> void:
	var list := InputMap.get_action_list(action)
	var data := {actions = list}
	save(path_template % action, data)


static func load2inputmap(action: String) -> void:
	var data := load_file(path_template % action)
	if typeof(data) == TYPE_DICTIONARY and typeof(data.get("actions", false)) == TYPE_ARRAY:
		for e in data.actions:  # validate
			if e is InputEvent and RemapUtilities.is_valid_action(e):
				continue
			push_error("Invalid action: %s" % e)
			inputmap2file(action)  # reset if invalid
			return
		RemapUtilities.clear_mappings(action)
		for e in data.actions:
			RemapUtilities.add_action(action, e)
		return
	inputmap2file(action)
