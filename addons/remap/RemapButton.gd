## Provides a button that allows remapping [InputEventAction]s.

@icon("./icons/remap_button.svg")
extends HBoxContainer
class_name RemapButton

const RemapUtilities := preload("./private/RemapUtilities.gd")
const SaveLoadUtils := preload("./private/SaveLoadUtils.gd")

## Wether to have a clear button.
@export var clear_button := true

## The text for said clear button.
@export var clear_text := "✗"

## The text used to prompt the player to press a key.
@export var prompt_text := "[press any key]"

## The button text.
@export var _name := ""

## The action to follow.
@export var action := ""

## The minimum ActionIcon size.
@export var icon_size := Vector2(20, 20)

## The font to use. Only change if your font has the [url=https://github.com/Shinmera/promptfont/blob/c27797b49dee560e3ea3eaa40e87f9a7f35e8913/glyphs.json]necessary glyphs[/url].
@export var font: Font = preload("./PromptFont.ttf")

## The font size. See also [member font]
@export var font_size: int = 16

## Wether to update continuously.
## Usefull if you have multple RemapButtons following this action.
## If you need this for a different reason, eg resetting all inputs to the default ([code]InputMap.load_from_project_settings[/code]),
## it is more efficient to manually call [method update] and [method save].
@export var continuous_updating := false


## The device the input is mapped to. Set to -2 to disable.
## -1 = all devices = player1 maps button a to jump. player2 presses a and player1 jumps. (good for singleplayer)
## 0 = device 0. player1 maps button a to jump, player0 presses a and player0 jumps. (good when you explicitly state which player its for)
## -2 = player1 maps button a to jump, player1 presses jump and player1 jumps.
## Make sure that you set your inputs in the editor `InputMap` correctly, or players will be able to have two icons of the same type on one action.
@export var device := -2


## The internal ActionIcons object. This is a required internal node.
var icons: ActionIcons = null

## The internal [Button] object. This is a required internal node.
var button := Button.new()

## The clear button.
var clear: Button

func _ready() -> void:
  assert(font != null)
  set_process_input(false)
  custom_minimum_size = icon_size
  DirAccess.make_dir_absolute(SaveLoadUtils.dir)
  SaveLoadUtils.load_action_to_inputmap(action)
  if clear_button:
    clear = Button.new()
    clear.text = clear_text
    clear.pressed.connect(clear_mappings)
    clear.size_flags_vertical = SIZE_EXPAND_FILL
    clear.custom_minimum_size = icon_size
    clear.add_theme_font_override("font", font)
    clear.add_theme_font_size_override("font_size", font_size)
    clear.visible = InputMap.action_get_events(action).size() > 0
    add_child(clear)
  button.text = _name
  button.custom_minimum_size = icon_size
  button.size_flags_vertical = SIZE_EXPAND_FILL
  button.pressed.connect(_pressed)
  var spacer := Control.new()
  spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
  icons = ActionIcons.new(action, icon_size, font, font_size, continuous_updating)
  add_child(button)
  add_child(spacer)
  add_child(icons)

func _pressed():
  button.text = prompt_text
  set_process_input(true)

func _input(event: InputEvent) -> void:
  if event.is_pressed() or not RemapUtilities.is_valid_action(event): # wait for release
    return
  if event is InputEventKey and event.physical_keycode == KEY_ESCAPE:
    get_viewport().set_input_as_handled()
    button.text = _name
    set_process_input(false)
    return
  if event is InputEventJoypadMotion:
    event.axis_value = sign(event.axis_value)
  get_viewport().set_input_as_handled()
  if device != -2 and not event is InputEventKey: # for some reason keys dont have devices, guess you cant connect multiple keyboards smh
    event.device = device
  RemapUtilities.add_action(action, event)
  if not continuous_updating:
    update()
  save()
  button.text = _name
  set_process_input(false)

## Clears the mappings for this action.
func clear_mappings():
  RemapUtilities.clear_mappings(action)
  if not continuous_updating:
    icons.update()
  SaveLoadUtils.action_to_file(action)
  clear.hide()

## Saves the rebind data to a file. Only necessary if manually changing the [InputMap].
func save():
  SaveLoadUtils.action_to_file(action)
  clear.visible = InputMap.action_get_events(action).size() > 0

## Updates the icon visuals.
func update() -> void:
  if continuous_updating:
    push_error("Continuous updating set, manually calling update() pointless.")
    return
  icons.update(true)
