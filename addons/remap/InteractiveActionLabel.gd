extends ActionLabel
class_name InteractiveActionLabel


# if this is overriden, the new scene must
# - have a confirmed(action: InputEvent) signal
# - have a cancelled() signal
# - free itself when one of them is emitted
export(PackedScene) var popup = preload("./KeySelector.tscn")

func _ready():
	var clear := Button.new()
	clear.theme = preload("./main.theme")
	clear.text = "✗"
	clear.connect("pressed", self, "clear")
	clear.size_flags_vertical = SIZE_EXPAND_FILL
	clear.rect_min_size.x = 30
	add_child(clear)
	move_child(clear, 0)


func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var selector = popup.instance()
		add_child(selector)
		selector.connect("confirmed",self,"_on_key_selected")


func _on_key_selected(event: InputEvent):
	RemapUtilities.add_action(action,event)
	icons._update()

func clear():
	RemapUtilities.clear_mappings(action)
	icons._update()
