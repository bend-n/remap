extends Control


func _ready():
	var label = RemapButton.new()
	label.action = "ui_left"
	label._name = "left"
	add_child(label)
