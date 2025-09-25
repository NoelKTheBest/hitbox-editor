extends Sprite2D

var _hf : int
var _vf : int
var frame_size : Vector2i
var hframe_positions = []
var vframe_positions = []
var frame_rects = []
@onready var parent: Sprite2D = $".."

func _ready() -> void:
	_hf = parent.hframes
	_vf = parent.vframes
	
	frame_size = texture.get_size()
	frame_size.x = frame_size.x / _hf
	frame_size.y = frame_size.y / _vf
	#print(frame_size)
	
	for i in range(_hf):
		var x = frame_size.x * i
		hframe_positions.append(Vector2i(x, 0))
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
			draw_line(Vector2i(hline.x - 336, 0), Vector2i(hline.x - 336, frame_size.y), Color.WHITE)
	
	if vframe_positions.size() > 1:
		for vline in vframe_positions:
			draw_line(Vector2i(-336, vline.y), Vector2i(336, vline.y), Color.WHITE)


func _set_hframes(hf: int):
	if hf < 1: _hf = 1


func _set_vframes(vf: int):
	if vf < 1: _vf = 1
