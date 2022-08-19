extends HBoxContainer
class_name ActionIcons

var action: String


func _ready():
	theme = preload("./main.theme")
	add_constant_override("separation", 4)


func _update():
	for i in get_children():
		i.queue_free()
	var act_list := InputMap.get_action_list(action)
	for e in act_list:
		var icon = IconMap.get_icon(e)
		if icon:
			var p: PanelContainer = PanelContainer.new()
			var i: Label = Label.new()
			i.text = icon
			i.align = Label.ALIGN_CENTER
			i.valign = Label.VALIGN_CENTER
			p.add_child(i)
			add_child(p)
			i.rect_min_size = Vector2(30, 30)
