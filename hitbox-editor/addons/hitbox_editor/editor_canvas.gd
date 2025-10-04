@tool extends Sprite2D

@onready var control_window: Control = $"../../.."
@onready var extra_container: HBoxContainer = $"../.."

class BoxArea:
	var index : int
	var properties : PerFrameProperties

class PerFrameProperties:
	var rects = []
	var box_active_on_frames = []
	var frame_numbers = []

var hitbox_color = Color(0.98, 0.039, 0.055, 0.5)
var hurtbox_color = Color(0.204, 0.761, 0.188, 0.5)
var current_color = Color(0.98, 0.039, 0.055, 0.5)
var is_curr_type_hurt = false
var drawing_rect : Rect2i
var hitboxes = []
var hurtboxes = []
var window_is_visible
var frame_count
var frame_number_map = []

enum drag_modes {PAN, CREATE}

var drag_mode = drag_modes.PAN
var dragging : bool
var drag_box : bool
var start_pos : Vector2i
var end_pos : Vector2i

func _draw():
	draw_rect(drawing_rect, current_color)
	for hitbox in hitboxes:
		#draw_rect(hitbox.properties.rects[frame], hitbox_color)
		pass
	for hurtbox in hurtboxes:
		#draw_rect(hurtbox.rect, hurtbox_color)
		pass


func _input(event):
	if window_is_visible and visible:
		var box_pos : Vector2i
		# we will have an array of boxes to use and 
		#	we check every frame to see if each of these boxes 
		#	has the position from the event
		var current_box_id : int
		var current_box_pos : Vector2i
		
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			#	drag_box = true
			search_boxes()
			if get_rect().has_point(to_local(event.position)) and !drag_box:
				var local_event_position = to_local(event.position)
				if !dragging:
					dragging = true
					start_pos = local_event_position
				if dragging:
					end_pos = local_event_position
					drawing_rect = Rect2i(start_pos, end_pos - start_pos)
					#print(drawing_rect)
		
		if event is InputEventMouseButton and !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			#	drag_box = false
			if get_rect().has_point(to_local(event.position)) and !drag_box:
				var local_event_position = to_local(event.position)
				dragging = false
				end_pos = local_event_position
				
				# Create a new BoxArea and set properties. Add to appropriate array
				define_box()
				
				# Define new area to add to the scene
				var new_area : Area2D = Area2D.new()
				var shape : CollisionShape2D = CollisionShape2D.new()
				var rect_shape = RectangleShape2D.new()
				
				var negx = false
				var negy = false
				
				if drawing_rect.size.x < 0:
					negx = true
					drawing_rect.size.x = absi(drawing_rect.size.x)
					
				if drawing_rect.size.y < 0:
					negy = true
					drawing_rect.size.y = absi(drawing_rect.size.y)
				
				rect_shape.size = drawing_rect.size
				shape.shape = rect_shape
				new_area.add_child(shape)
				add_child(new_area)
				#var rectpos = to_global(drawing_rect.position)
				var halfsize = Vector2i(drawing_rect.size.x / 2, drawing_rect.size.y / 2)
				new_area.position = drawing_rect.position + (halfsize)
				
				# If either the x or y vars of the rect size is negative, 
				#	subtract the position of the corresponding axis
				if negx: new_area.position.x -= drawing_rect.size.x
				if negy: new_area.position.y -= drawing_rect.size.y
				var modx = drawing_rect.size.x % 2
				var mody = drawing_rect.size.y % 2
				
				# Add 0.5 to the position (if needed) to make it line up exactly with the drawn rect
				new_area.position.x += modx / 2.0
				new_area.position.y += mody / 2.0
				#print("size: ", drawing_rect.size)
				#print("dpos: ", drawing_rect.position, " npos: ",drawing_rect.position + (halfsize))
				
		
		# If we are currently drawing a box, check for MouseMotion instead of MouseButton
		if dragging and event is InputEventMouseMotion:
			var local_event_position = to_local(event.position)
			end_pos = local_event_position
			drawing_rect = Rect2i(start_pos, end_pos - start_pos)
			#print(drawing_rect)
			queue_redraw()


func search_boxes():
	#create a for loop to search through all hitboxes and hurtboxes to see if one if a target for
	#	translation
	for hitbox in hitboxes:
		pass


# Define a box in a specific frame. Copy contents of frame properties to a new frame when switching
func define_box():
	print(get_rect())
	# Create a new BoxArea with new PerFrameProperties
	var new_box = BoxArea.new()
	
	# I am thinking of using this to know when to add another Area2D node to the 
	#	instantiated scene in ControlWindow
	#new_box.index = 0
	
	# Check if the properties class already has these vars defined
	new_box.properties = PerFrameProperties.new()
	new_box.properties.rects.resize(frame_count)
	new_box.properties.box_active_on_frames.resize(frame_count)
	#new_box.properties.frame_numbers.resize(frame_count)
	var i = frame_number_map.find(frame)
	new_box.properties.rects.fill(drawing_rect)
	
	if is_curr_type_hurt: 
		new_box.index = hurtboxes.size()
		hurtboxes.append(new_box)
	else:
		new_box.index = hitboxes.size()
		hitboxes.append(new_box)


func copy_in_frame(box: BoxArea):
	var i = frame_number_map.find(frame)
	box.properties.rects


func _on_check_button_toggled(toggled_on: bool) -> void:
	is_curr_type_hurt = toggled_on
	if toggled_on: current_color = hurtbox_color
	else: current_color = hitbox_color


# Use this function to check if in the previous frame, 
#	there are any properties that can be copied. If so,
#	copy those properties.
#
#	We can also use this function to set and change certain
#	controls in the editor window such as the control that
#	will show the current box that is selected (which also
#	will indicate that the box can be moved and that we are
#	not currently dragging anything), it's type and wether 
#	it is active in the current frame
func _on_frame_changed() -> void:
	for hitbox in hitboxes:
		#copy_in_frame(hitbox)
		pass
	
	
