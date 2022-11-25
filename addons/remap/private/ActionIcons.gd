## Displays multiple ActionIcons.

extends HBoxContainer
@icon("../icons/action_icons.svg")

const ActionIcon := preload("./ActionIcon.gd")
const IconMap := preload("./IconMap.gd")

## The action to follow.
var action: String

## The minimum icon size.
var min_size := Vector2(20, 20)

## The font to use
var font: Font

func _init(p_action: String, p_min_size: Vector2, p_font: Font) -> void:
  action = p_action
  min_size = p_min_size
  font = p_font

## Updates the icons to the latest inputs.
func update():
  for i in get_children():
    i.queue_free()
  for e in InputMap.action_get_events(action):
    var icon := IconMap.get_icon(e)
    add_child(ActionIcon.new(icon, min_size, font))
