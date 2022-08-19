extends Label

var selected: InputEvent


func _input(event: InputEvent) -> void:
	if !RemapUtilities.is_valid_action(event) or event is InputEventMouseButton:
		return
	if event is InputEventJoypadMotion:
		event.axis_value = sign(event.axis_value)
	selected = event
	text = IconMap.get_icon(event)
	$"%ok".disabled = false
