extends Control


func _ready():
	var label = InteractiveActionLabel.new()
	label.action = "ui_left"
	label._name = "left"
	add_child(label)
