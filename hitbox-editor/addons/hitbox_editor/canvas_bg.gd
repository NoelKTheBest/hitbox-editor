@tool extends Sprite2D


func _on_h_slider_value_changed(value: float) -> void:
	scale.x *= value
	scale.y *= value
