@tool extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		text = "Hurtboxes"
	else:
		text = "Hitboxes"
