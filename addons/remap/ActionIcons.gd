extends HBoxContainer
class_name ActionIcons

export(String) var action: String
export(Vector2) var size := Vector2(20, 20)
export(bool) var override_font := true

const font = preload("./PromptFont.tres")


func _update():
	for i in get_children():
		i.queue_free()
	var act_list := InputMap.get_action_list(action)
	for e in act_list:
		var icon = IconMap.get_icon(e)
		if icon:
			var p: PanelContainer = PanelContainer.new()
			var i: Label = Label.new()
			if override_font:
				i.add_font_override("font", font)
			i.text = icon
			i.align = Label.ALIGN_CENTER
			i.valign = Label.VALIGN_CENTER
			p.add_child(i)
			add_child(p)
			i.rect_min_size = size
