tool
extends HBoxContainer
class_name ActionLabel

export(String) var _name: String
export(String) var action: String
export(Vector2) var icon_size := Vector2(30, 30)
export(bool) var override_font := true

var icons := ActionIcons.new()
var name_label := Label.new()


func _ready() -> void:
	SaveLoadUtils.create_dir(SaveLoadUtils.dir)
	SaveLoadUtils.load2inputmap(action)
	name_label.text = _name
	name_label.valign = Label.VALIGN_CENTER
	name_label.align = Label.ALIGN_CENTER
	add_child(name_label)
	var spacer := Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_child(spacer)
	add_child(icons)
	icons.action = action
	icons.size = icon_size
	icons.override_font = override_font
	icons._update()
