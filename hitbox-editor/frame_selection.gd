extends Sprite2D

@export var h : int = 1
@export var v : int = 1
@export var font : Font
var _hf : int
var _vf : int
var frame_size : Vector2i
var frame_index : int
var texture_width_offset : int
var texture_height_offset : int
var hframe_positions = []
var vframe_positions = []
var frame_rects = []
var actual_frames = []
var coordinates = []
var selected_frames = []
var selected_frame_areas = []
var current_animation = []
var animations = []
var current_frame_rect : Rect2i
#@onready var parent: Sprite2D = $".."

func _ready() -> void:
	slice_texture()


func _draw() -> void:
	if hframe_positions.size() > 1:
		for hline in hframe_positions:
			draw_line(Vector2i(hline.x, -texture_height_offset), Vector2i(hline.x, texture_height_offset), Color.WHITE)
	
	if vframe_positions.size() > 1:
		for vline in vframe_positions:
			draw_line(Vector2i(-texture_width_offset, vline.y), Vector2i(texture_width_offset, vline.y), Color.WHITE)
	
	for selections in selected_frame_areas:
		draw_rect(selections, Color(0.17, 0.627, 1, 0.514))
		var fdx = selections.position.x + 2.5
		var fdy = selections.position.y + 15
		draw_string(font, Vector2(fdx, fdy), str(selected_frame_areas.find(selections)))
	
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
				var fi = frame_rects.find(area)
				#print(actual_frames[fi])
				#print(coordinates[fi])
				queue_redraw()
	
	if event is InputEventMouseButton and event.pressed:
		for area in frame_rects:
			if area.has_point(to_local(event.position)):
				var fi = frame_rects.find(area)
				
				if !selected_frame_areas.has(area):
					selected_frame_areas.append(area)
					selected_frames.append(actual_frames[fi])
				else:
					selected_frame_areas.erase(area)
					selected_frames.erase(actual_frames[fi])
				
				print(selected_frames)


func slice_texture():
	_hf = h
	_vf = v
	
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
		vframe_positions.append((Vector2i(0, y - texture_height_offset)))
	
	frame_index = 0
	for j in range(_vf):
		for i in range(_hf):
			frame_rects.append(Rect2i(hframe_positions[i].x, vframe_positions[j].y, frame_size.x, frame_size.y))
			actual_frames.append(frame_index)
			frame_index += 1
			coordinates.append(Vector2(i, j))
	
	#print(hframe_positions)
	#print(vframe_positions)
	#print(frame_rects)
	#print(actual_frames)
	#print(coordinates)
