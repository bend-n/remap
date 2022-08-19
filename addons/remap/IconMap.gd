extends Reference
class_name IconMap

const key_map := {
	KEY_LEFT: "←",
	KEY_RIGHT: "→",
	KEY_UP: "↑",
	KEY_DOWN: "↓",
	KEY_ENTER: "␮",
	KEY_KP_ENTER: "␮",
	KEY_HOME: "␵",
	KEY_CONTROL: "␧",
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

# JOY_SONY_CIRCLE and JOY_XBOX_B are the same as JOY_DS_A
# TODO: use a different map for each controller after finding out what kind it is
const gamepad_button_map := {
	JOY_XBOX_X: "↤",
	JOY_XBOX_A: "↧",
	JOY_XBOX_B: "↦",
	JOY_XBOX_Y: "↥",
	JOY_L: "↘",
	JOY_R: "↙",
	JOY_L2: "↖",
	JOY_R2: "↗",
	JOY_DPAD_LEFT: "↞",
	JOY_DPAD_RIGHT: "↠",
	JOY_DPAD_UP: "↟",
	JOY_DPAD_DOWN: "↡",
}

const joystick_map := {
	-1:
	{
		JOY_ANALOG_LX: "↼",
		JOY_ANALOG_LY: "⇈",
		JOY_ANALOG_RX: "↽",
		JOY_ANALOG_RY: "↿",
	},
	1:
	{
		JOY_ANALOG_LX: "⇀",
		JOY_ANALOG_LY: "⇂",
		JOY_ANALOG_RX: "⇁",
		JOY_ANALOG_RY: "⇃",
	}
}

const mouse_button_map := {
	BUTTON_LEFT: "⟵", BUTTON_RIGHT: "⟶", BUTTON_MIDDLE: "⟷", BUTTON_WHEEL_DOWN: "⟱", BUTTON_WHEEL_UP: "⟰"
}


static func get_icon(e: InputEvent) -> String:
	if e is InputEventKey:
		if key_map.has(e.scancode):
			return key_map[e.scancode]
		elif OS.get_scancode_string(e.scancode):
			return OS.get_scancode_string(e.scancode)
		elif OS.keyboard_get_scancode_from_physical(e.physical_scancode):
			var scancode = OS.keyboard_get_scancode_from_physical(e.physical_scancode)
			if key_map.has(scancode):
				return key_map[scancode]
			elif OS.get_scancode_string(scancode):
				return OS.get_scancode_string(scancode)

	elif e is InputEventJoypadButton:
		if gamepad_button_map.has(e.button_index):
			return gamepad_button_map[e.button_index]
	elif e is InputEventJoypadMotion:
		if joystick_map[int(e.axis_value)].has(e.axis):
			return joystick_map[int(e.axis_value)][e.axis]
	elif e is InputEventMouseButton:
		if mouse_button_map.has(e.button_index):
			return mouse_button_map[e.button_index]
	return "❓"
