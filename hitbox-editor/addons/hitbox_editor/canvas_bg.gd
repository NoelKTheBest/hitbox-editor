@tool extends Sprite2D

@onready var editor = $EditorCanvas
var first_frame
var last_frame

func _draw() -> void:
	var texture_rect = get_rect()
	draw_rect(texture_rect, Color(1, 1, 1, 0.3))


func _on_h_slider_value_changed(value: float) -> void:
	scale.x = value
	scale.y = value


func _on_hframes_value_changed(value: float) -> void:
	hframes = value
	$EditorCanvas.hframes = value


func _on_vframes_value_changed(value: float) -> void:
	vframes = value
	$EditorCanvas.vframes = value


func _on_frame_select_value_changed(value: float) -> void:
	frame = value
	$EditorCanvas.frame = value


func _on_texture_changed() -> void:
	editor.texture = texture
	editor.hframes = hframes
	editor.vframes = vframes
	editor.frame = frame
	editor.frame_count = (last_frame - frame) + 1
	for f in range(frame, last_frame + 1):
		editor.frame_number_map.append(f)
	
