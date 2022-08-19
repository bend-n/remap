extends Node
class_name KeySelector

signal confirmed(event)
signal cancelled


func _ready():
	$"%ok".connect("pressed", self, "confirmed")
	$"%cancel".connect("pressed", self, "cancelled")


func confirmed():
	emit_signal("confirmed", $"%KeyPrompter".selected)
	queue_free()


func cancelled():
	emit_signal("cancelled")
	queue_free()
