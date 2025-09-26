extends Sprite2D

var _hf : int
var _vf : int
var frame_size : Vector2i
var texture_width_offset : int
var texture_height_offset : int
var hframe_positions = []
var vframe_positions = []
var frame_rects = []
var current_frame_rect : Rect2i
#@onready var parent: Sprite2D = $".."

func _ready() -> void:
	_hf = 7
	_vf = 1
	
	frame_size = texture.get_size()
	texture_width_offset = frame_size.x / 2
	texture_height_offset = frame_size.y / 2
	frame_size.x = frame_size.x / _hf
	frame_size.y = frame_size.y / _vf
	#print(frame_size)
	
	for i in range(_hf):
		var x = frame_size.x * i
		hframe_positions.append(Vector2i(x - texture_width_offset, 0))
		#print(Vector2i(x, 0))
	
	for i in range(_vf):
		var y = frame_size.y * i
		vframe_positions.append((Vector2i(0, y)))
	
	for i in range(_hf):
		for j in range(_vf):
			frame_rects.append(Rect2i(hframe_positions[i].x, vframe_positions[j].y, frame_size.x, frame_size.y))
	
	#print(hframe_positions)
	#print(vframe_positions)
	#print(frame_rects)


func _draw() -> void:
	if hframe_positions.size() > 1:
		for hline in hframe_positions:
			draw_line(Vector2i(hline.x, 0), Vector2i(hline.x, frame_size.y), Color.WHITE)
	
	if vframe_positions.size() > 1:
		for vline in vframe_positions:
			draw_line(Vector2i(-texture_width_offset, vline.y), Vector2i(texture_width_offset, vline.y), Color.WHITE)
	
	draw_rect(current_frame_rect, Color(0.33, 0.866, 1, 0.518))


func _set_hframes(hf: int):
	if hf < 1: _hf = 1


func _set_vframes(vf: int):
	if vf < 1: _vf = 1


func _input(event):
	if event is InputEventMouseMotion:
		for area in frame_rects:
			if area.has_point(to_local(event.position)):
				var local_event_position = to_local(event.position)
				current_frame_rect = area
				queue_redraw()
