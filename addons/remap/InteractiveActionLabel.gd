extends ActionLabel
class_name InteractiveActionLabel

# if this is overriden, the new scene must
# - have a confirmed(action: InputEvent) signal
# - have a cancelled() signal
# - free itself when one of them is emitted
export(PackedScene) var popup = preload("./KeySelector.tscn")

var clear: Button

export(bool) var clear_button := true
export(String) var clear_text := "✗"


func _ready():
	if clear_button:
		clear = Button.new()
		clear.text = clear_text
		clear.connect("pressed", self, "clear")
		clear.size_flags_vertical = SIZE_EXPAND_FILL
		clear.rect_min_size = icon_size
		add_child(clear)
		move_child(clear, 0)
		clear.visible = InputMap.get_action_list(action).size() > 0
		if override_font:
			clear.add_font_override("font", preload("./PromptFont.tres"))


func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
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
