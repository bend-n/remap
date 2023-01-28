## Displays multiple ActionIcons.

@icon("../icons/action_icons.svg")
extends HBoxContainer

const ActionIcon := preload("./ActionIcon.gd")
const IconMap := preload("./IconMap.gd")

## The action to follow.
var action: String

## The minimum icon size.
var min_size := Vector2(20, 20)

## The font to use.
var font: Font

## Font size.
var font_size: int

## The last result of [method Input.action_get_events].
var last_acts: Array[InputEvent]

## Updating continuously.
var continuous_updating: bool

## Cache the currently connected joypads
var current_connected_joypads_type := IconMap.get_connected_joypads_type()

func _init(p_action: String, p_min_size: Vector2, p_font: Font, p_font_size: int, p_continuous_updating) -> void:
  action = p_action
  min_size = p_min_size
  font = p_font
  font_size = p_font_size
  continuous_updating = p_continuous_updating
  if continuous_updating:
    return
  set_process(false)
  Input.joy_connection_changed.connect(
    func(_device: int, _connected: bool) -> void:
      current_connected_joypads_type = IconMap.get_connected_joypads_type()
      update(true)
  )
  update()


func _process(_delta: float) -> void:
  update()

## Updates the icons to the latest inputs.
func update(force := false):
  var acts := InputMap.action_get_events(action)
  if force or acts != last_acts:
    last_acts = acts

    # make sure we had enough children
    var child_diff := acts.size() - get_child_count()
    while child_diff < 0:
      # kill our children if we had too many
      get_child(child_diff).queue_free()
      child_diff += 1
    while child_diff > 0:
      # bear new children if we dont have enough
      add_child(ActionIcon.new(min_size, font, font_size))
      child_diff -= 1

    # set the children
    for i in acts.size():
      get_child(i).set_text(IconMap.get_icon(acts[i], current_connected_joypads_type))
