## Provides a button that allows remapping [InputEventAction]s.

extends HBoxContainer
@icon("./icons/remap_button.svg")

const ActionIcons := preload("./private/ActionIcons.gd")
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

## The font to use.
@export var font: Font = preload("./PromptFont.ttf")

## Wether to update continuously. Usefull if you have multple RemapButtons following this action.
@export var continuous_updating := false

## The internal ActionIcons object. This is a required internal node.
var icons: ActionIcons = null

## The internal [Button] object. This is a required internal node.
var button := Button.new()

## The clear button.
var clear: Button

func _ready() -> void:
  set_process(continuous_updating)
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
    add_child(clear)
    clear.visible = InputMap.action_get_events(action).size() > 0
    if font:
      clear.add_theme_font_override("font", font)
  button.text = _name
  button.custom_minimum_size = icon_size
  button.size_flags_vertical = SIZE_EXPAND_FILL
  button.pressed.connect(_pressed)
  var spacer := Control.new()
  spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
  icons = ActionIcons.new(action, icon_size, font)
  add_child(button)
  add_child(spacer)
  add_child(icons)
  if not continuous_updating:
    icons.update()

func _pressed():
  button.text = prompt_text
  set_process_input(true)

func _input(event: InputEvent) -> void:
  if (
      not event.is_pressed() 
      or event in [InputEventMouseMotion, InputEventScreenDrag]
      or (
        (event is InputEventJoypadMotion or event is InputEventJoypadButton) and
        Input.get_joy_name(event.device) == "HTIX5288:00 0911:5288 Touchpad" # work around https://github.com/godotengine/godot/issues/69153
      )
    ):
    return

  if event is InputEventKey and event.physical_keycode == KEY_ESCAPE or not RemapUtilities.is_valid_action(event):
    get_viewport().set_input_as_handled()
    button.text = _name
    set_process_input(false)
    return
  if event is InputEventJoypadMotion:
    event.axis_value = sign(event.axis_value)
  get_viewport().set_input_as_handled()
  RemapUtilities.add_action(action, event)
  if not continuous_updating:
    icons.update()
  SaveLoadUtils.action_to_file(action)
  clear.show()
  button.text = _name
  set_process_input(false)

## Clears the mappings for this action.
func clear_mappings():
  RemapUtilities.clear_mappings(action)
  icons.update()
  SaveLoadUtils.action_to_file(action)
  clear.hide()

func _process(_delta: float) -> void:
  icons.update()
