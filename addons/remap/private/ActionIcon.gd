## A ActionIcon used by ActionIcons.

@icon("../icons/action_icon.svg")
extends PanelContainer

## The inner label.
var label := Label.new()


func _init(min_size: Vector2, font: Font, font_size: int) -> void:
	label.horizontal_alignment = BoxContainer.ALIGNMENT_CENTER
	label.vertical_alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(label)
	label.custom_minimum_size = min_size
	label.add_theme_font_override("font", font)
	label.add_theme_font_size_override("font_size", font_size)


## Sets the text of the inner label.
func set_text(text: String):
	label.text = text
