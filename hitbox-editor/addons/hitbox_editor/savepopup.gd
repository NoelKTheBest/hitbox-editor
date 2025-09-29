@tool
extends Button

func _ready() -> void:
	$PopupMenu.position = position


func _on_pressed() -> void:
	$PopupMenu.visible = !$PopupMenu.visible
