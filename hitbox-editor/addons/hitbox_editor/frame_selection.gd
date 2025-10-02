@tool
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
var curr_anim_num = 0
var animations = []
var animation_names = []
var custom_anim_name
var anim_lib_name : String

var current_frame_rect : Rect2i
#@onready var parent: Sprite2D = $".."
@onready var anim_list: ItemList = $"../../../VBoxContainer/ItemList"
@onready var control_window: Control = $"../../../.."
@onready var main_container: VBoxContainer = $"../../.."
var scene


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
	if control_window.visible and main_container.visible:
		if event is InputEventMouseMotion:
			for area in frame_rects:
				if area.has_point(to_local(event.position)):
					var local_event_position = to_local(event.position)
					current_frame_rect = area
					var fi = frame_rects.find(area)
					#print(actual_frames[fi])
					#print(coordinates[fi])
					queue_redraw()
		
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
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


func _on_popup_menu_id_pressed(id: int) -> void:
	if id == 0:
		var new_anim = Animation.new()
		# Add Animation Tracks and get track index
		var tit = new_anim.add_track(Animation.TYPE_VALUE)
		var tihf = new_anim.add_track(Animation.TYPE_VALUE)
		var tivf = new_anim.add_track(Animation.TYPE_VALUE)
		var tif = new_anim.add_track(Animation.TYPE_VALUE)
		
		# Set the track's property path
		new_anim.track_set_path(tit, ":texture")
		new_anim.track_set_path(tihf, ":hframes")
		new_anim.track_set_path(tivf, ":vframes")
		new_anim.track_set_path(tif, ":frame")
		
		# Insert main key for hframe, vframe and texture tracks
		new_anim.track_insert_key(tit, 0.0, texture)
		new_anim.track_insert_key(tihf, 0.0, _hf)
		new_anim.track_insert_key(tivf, 0.0, _vf)
		
		var i = 0.0
		for frames in selected_frames:
			new_anim.track_insert_key(tif, i, frames)
			i += 0.1
		
		new_anim.length = i + 0.1
		print(new_anim)
		var path
		if custom_anim_name:
			path = "res://" + custom_anim_name + ".tres"
			animation_names.append(custom_anim_name)
		else:
			path = "res://Anim" + str(curr_anim_num) + ".tres"
			curr_anim_num += 1
			animation_names.append("Anim" + str(curr_anim_num))
		animations.append(new_anim)
		ResourceSaver.save(new_anim, path)
	elif id == 1:
		if anim_lib_name.length() > 0:
			#var new_anim_lib = AnimationLibrary.new()
			var path = "res://" + anim_lib_name + ".res"
			var i = 0
			var temp = []
			for anim in animations:
				var temp_string = animation_names[i].trim_prefix("res://").get_slice('.', 0)
				print(temp_string)
				#new_anim_lib.add_animation(animation_names[i], anim)
				i += 1
			
			#ResourceSaver.save(new_anim_lib, path)
		else:
			print_rich("[color=yellow]You need to have a name for the animation library to save it")


func _on_line_edit_text_changed(new_text: String) -> void:
	anim_lib_name = new_text


func _on_visibility_changed() -> void:
	pass
