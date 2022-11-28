## A action label. Displays the inputevents for a action, with a label.

extends HBoxContainer
@icon("./icons/action_label.svg")

const IconMap := preload("./private/IconMap.gd")
const ActionIcons := preload("./private/ActionIcons.gd")
const SaveLoadUtils := preload("./private/SaveLoadUtils.gd")

## The label text.
@export var _name := ""

## The action to follow.
@export var action := ""

## The minimum ActionIcon size.
@export var icon_size := Vector2(20, 20)

## The font to use. Only change if your font has the [url=https://github.com/Shinmera/promptfont/blob/c27797b49dee560e3ea3eaa40e87f9a7f35e8913/glyphs.json]necessary glyphs[/url].
@export var font: Font = preload("./PromptFont.ttf")

## The font size. See also [member font]
@export var font_size: int = 16

## Wether to update continuously. Usefull if you have RemapButtons on this action.
## Also possible to manually call [method update].
@export var continuous_updating := false

## The ActionIcons object to use. This is a required internal node.
var icons: ActionIcons = null

## The label to display the button text on. This is not a required internal node.
var name_label := Label.new()

## The background for the label to display the button text on. This is not a required internal node.
var name_label_bg := PanelContainer.new()


func _ready() -> void:
	assert(font != null)
	DirAccess.make_dir_absolute(SaveLoadUtils.dir)
	SaveLoadUtils.load_action_to_inputmap(action)
	add_child(name_label_bg)
	name_label_bg.add_child(name_label)
	name_label.text = _name
	name_label.custom_minimum_size = icon_size
	name_label.vertical_alignment = ALIGNMENT_CENTER
	name_label.horizontal_alignment = ALIGNMENT_CENTER
	var spacer := Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	icons = ActionIcons.new(action, icon_size, font, font_size, continuous_updating)
	add_child(spacer)
	add_child(icons)


## Updates the icon visuals.
func update() -> void:
	if continuous_updating:
		push_error("Continuous updating set, manually calling update() pointless.")
		return
	icons.update(true)
