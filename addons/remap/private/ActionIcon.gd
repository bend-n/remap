## A ActionIcon used by ActionIcons.

extends PanelContainer
@icon("../icons/action_icon.svg")

## The inner label.
var label := Label.new()

func _init(text: String, min_size: Vector2, font: Font) -> void:
    label.horizontal_alignment = BoxContainer.ALIGNMENT_CENTER
    label.vertical_alignment = BoxContainer.ALIGNMENT_CENTER
    add_child(label)
    label.custom_minimum_size = min_size
    label.text = text
    if font:
        label.add_theme_font_override("font", font)
