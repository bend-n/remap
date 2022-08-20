extends HBoxContainer
class_name RemapButton

# if this is overriden, the new scene must
# - have a confirmed(action: InputEvent) signal
# - have a cancelled() signal
# - free itself when one of them is emitted
export(PackedScene) var popup = preload("./KeySelector.tscn")


export(bool) var clear_button := true
export(String) var clear_text := "✗"
export(String) var _name: String
export(String) var action: String
export(Vector2) var icon_size := Vector2(20, 20)
export(bool) var override_font := true

var icons := ActionIcons.new()
var button := Button.new()
var clear: Button

func _ready() -> void:
	rect_min_size = icon_size
	SaveLoadUtils.create_dir(SaveLoadUtils.dir)
	SaveLoadUtils.load2inputmap(action)
	if clear_button:
		clear = Button.new()
		clear.text = clear_text
		clear.connect("pressed", self, "clear")
		clear.size_flags_vertical = SIZE_EXPAND_FILL
		clear.rect_min_size = icon_size
		add_child(clear)
		clear.visible = InputMap.get_action_list(action).size() > 0
		if override_font:
			clear.add_font_override("font", preload("./PromptFont.tres"))
	button.text = _name
	button.rect_min_size = icon_size
	button.size_flags_vertical = SIZE_EXPAND_FILL
	button.connect("pressed", self, "_pressed")
	var spacer := Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	icons.action = action
	icons.size = icon_size
	icons.override_font = override_font
	icons._update()
	add_child(button)
	add_child(spacer)
	add_child(icons)



func _pressed():
	var selector = popup.instance()
	add_child(selector)
	selector.connect("confirmed", self, "_on_key_selected")


func _on_key_selected(event: InputEvent):
	RemapUtilities.add_action(action, event)
	icons._update()
	SaveLoadUtils.inputmap2file(action)
	clear.show()


func clear():
	RemapUtilities.clear_mappings(action)
	icons._update()
	SaveLoadUtils.inputmap2file(action)
	clear.hide()