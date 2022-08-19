extends Label

var selected: InputEvent


func _input(event: InputEvent) -> void:
	if !RemapUtilities.is_valid_action(event):
		return
	$"%ok".disabled = false
	selected = event
	text = IconMap.get_icon(event)
