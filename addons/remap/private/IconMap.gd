## Maps inputevents to a [url=https://shinmera.github.io/promptfont/]prompt font[/url] icon.

extends RefCounted

## The map for keys.
const KEY_MAP := {
	KEY_LEFT: "←",
	KEY_RIGHT: "→",
	KEY_UP: "↑",
	KEY_DOWN: "↓",
	KEY_ENTER: "␮",
	KEY_KP_ENTER: "␮",
	KEY_HOME: "␵",
	KEY_CTRL: "␧",
	KEY_ALT: "␨",
	KEY_SHIFT: "␩",
	KEY_SUPER_L: "␪",
	KEY_SUPER_R: "␫",
	KEY_TAB: "␫",
	KEY_CAPSLOCK: "␬",
	KEY_BACKSPACE: "␭",
	KEY_ESCAPE: "␯",
	KEY_PRINT: "␰",
	KEY_SCROLLLOCK: "␱",
	KEY_PAUSE: "␲",
	KEY_NUMLOCK: "␳",
	KEY_DELETE: "␷",
	KEY_INSERT: "␴",
	KEY_PAGEUP: "␶",
	KEY_PAGEDOWN: "␹",
	KEY_SPACE: "␺",
	KEY_F1: "①",
	KEY_F2: "②",
	KEY_F3: "③",
	KEY_F4: "④",
	KEY_F5: "⑤",
	KEY_F6: "⑥",
	KEY_F7: "⑦",
	KEY_F8: "⑧",
	KEY_F9: "⑨",
	KEY_F10: "⑩",
	KEY_F11: "⑪",
	KEY_F12: "⑫",
	KEY_SEMICOLON: ";",
	KEY_QUOTELEFT: "`",
	KEY_COMMA: ",",
	KEY_PERIOD: ".",
	KEY_SLASH: "/",
	KEY_BACKSLASH: "\\",
	KEY_MINUS: "-",
	KEY_EQUAL: "=",
	KEY_BRACKETLEFT: "[",
	KEY_BRACKETRIGHT: "]",
	KEY_BRACELEFT: "{",
	KEY_BRACERIGHT: "}",
	KEY_APOSTROPHE: "'",
	KEY_MENU: "⇻",
	KEY_END: "␸"
}

## Pad enum. Used to decide which button set to use.
enum PADS { XBOX, PLAYSTATION, NINTENDO, GENERIC }

## Generic joypad button mappings.
const JOYPAD_BUTTON_MAP := {
	JOY_BUTTON_LEFT_SHOULDER: "↘",
	JOY_BUTTON_RIGHT_SHOULDER: "↙",
	JOY_BUTTON_DPAD_LEFT: "↞",
	JOY_BUTTON_DPAD_RIGHT: "↠",
	JOY_BUTTON_DPAD_UP: "↟",
	JOY_BUTTON_DPAD_DOWN: "↡",
}

## Xbox button map.
const XBOX_BUTTON_MAP := {
	JOY_BUTTON_A: "↧",
	JOY_BUTTON_B: "↦",
	JOY_BUTTON_X: "↤",
	JOY_BUTTON_Y: "↥",
	JOY_BUTTON_BACK: "⇺",
	JOY_BUTTON_GUIDE: "",
	JOY_BUTTON_START: "⇻",
}

## PS button map.
const PLAYSTATION_BUTTON_MAP := {
	JOY_BUTTON_A: "⇣",
	JOY_BUTTON_B: "⇢",
	JOY_BUTTON_X: "⇠",
	JOY_BUTTON_Y: "⇡",
	JOY_BUTTON_BACK: "⇦",
	JOY_BUTTON_GUIDE: "",
	JOY_BUTTON_START: "⇨",
}

## Nintendo switch button map.
const NINTENDO_BUTTON_MAP := {
	JOY_BUTTON_A: "↥",
	JOY_BUTTON_B: "↧",
	JOY_BUTTON_X: "↥",
	JOY_BUTTON_Y: "↤",
	JOY_BUTTON_BACK: "⇽",
	JOY_BUTTON_GUIDE: "❓", # there is no joy_button_guide on switch
	JOY_BUTTON_START: "⇾",
}

## Joystick axis map.
## Index by joystick index (left or right) first.
const JOYSTICK_MAP := {
	-1:
	{
		JOY_AXIS_LEFT_X: "↼",
		JOY_AXIS_LEFT_Y: "⇈",
		JOY_AXIS_RIGHT_X: "↽",
		JOY_AXIS_RIGHT_Y: "↿",
	},
	1:
	{
		JOY_AXIS_LEFT_X: "⇀",
		JOY_AXIS_LEFT_Y: "⇂",
		JOY_AXIS_RIGHT_X: "⇁",
		JOY_AXIS_RIGHT_Y: "⇃",
	}
}

## Joypad trigger map.
const trigger_map := {JOY_AXIS_TRIGGER_LEFT: "↲", JOY_AXIS_TRIGGER_RIGHT: "↳"}

## Mouse button map.
const mouse_button_map := {
	MOUSE_BUTTON_LEFT: "⟵",
	MOUSE_BUTTON_RIGHT: "⟶",
	MOUSE_BUTTON_MIDDLE: "⟷",
	MOUSE_BUTTON_WHEEL_DOWN: "⟱",
	MOUSE_BUTTON_WHEEL_UP: "⟰"
}


## Tries to find the icon for a [param keycode].
static func check_key(keycode: int, physical: int, __r := false) -> String:
	if KEY_MAP.has(keycode):
		return KEY_MAP[keycode]
	var kcs := OS.get_keycode_string(keycode)
	if kcs:
		return kcs
	if !__r:
		var fallback := check_key(DisplayServer.keyboard_get_keycode_from_physical(physical), true)
		if fallback:
			return fallback
	return ""


## Partially lifted from [url=https://github.com/nathanhoad/godot_input_helper/blob/a6140576d3dc48e0296615c4f486456b331f2332/addons/input_helper/input_helper.gd#L48-L60]nathanhoad/godot_input_helper[/url].
## Naively tries to get the device, returning a PAD enum.
static func get_device(raw_name: String) -> int:
	raw_name = raw_name.to_lower()
	match raw_name:
		"xinput gamepad", "xbox series controller", "xbox 360 controller":
			return PADS.XBOX
		"sony dualsense", "ps5 controller", "ps4 controller":
			return PADS.PLAYSTATION
		"switch":
			return PADS.NINTENDO
		_:
			return PADS.GENERIC


## Gets the icon for a input[param e]vent. Returns [code]?[/code] on failure.
static func get_icon(e: InputEvent) -> String:
	if e is InputEventKey:
		var res := check_key(e.keycode, e.physical_keycode)
		if res:
			return res
	elif e is InputEventJoypadButton:
		if e.button_index < 7:
			match get_device(Input.get_joy_name(e.device)):
				PADS.XBOX:
					return XBOX_BUTTON_MAP[e.button_index]
				PADS.PLAYSTATION:
					return PLAYSTATION_BUTTON_MAP[e.button_index]
				PADS.NINTENDO:
					return NINTENDO_BUTTON_MAP[e.button_index]
				PADS.GENERIC:
					return XBOX_BUTTON_MAP[e.button_index] # fallback to xbox
	elif JOYPAD_BUTTON_MAP.has(e.button_index):
		return JOYPAD_BUTTON_MAP[e.button_index]
	elif e is InputEventJoypadMotion:
		if JOYSTICK_MAP[int(e.axis_value)].has(e.axis):
			return JOYSTICK_MAP[int(e.axis_value)][e.axis]
		if trigger_map.has(e.axis):
			return trigger_map[e.axis]
	elif e is InputEventMouseButton:
		if mouse_button_map.has(e.button_index):
			return mouse_button_map[e.button_index]
	push_error("Unable to map ", e)
	return "❓"