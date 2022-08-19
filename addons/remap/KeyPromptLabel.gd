extends Label

const motions = [
	InputEventMouseMotion,
	InputEventJoypadMotion,
	InputEventScreenDrag,
	InputEventScreenTouch,
	InputEventMIDI,
	InputEventMouseButton
]

var selected: InputEvent


func _input(event: InputEvent) -> void:
	if check_is(event, motions):
		return
	$"%ok".disabled = false
	selected = event
	text = IconMap.get_icon(event)


func check_is(it, is_it_a: Array) -> bool:
	for i in is_it_a:
		if it is i:
			return true
	return false
