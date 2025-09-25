extends Sprite2D

var hitbox_color = Color(0.98, 0.039, 0.055, 0.5)
var hurtbox_color = Color(0.204, 0.761, 0.188, 0.5)
var drawing_rect : Rect2i
var boxes = []

var dragging : bool
var drag_box : bool
var start_pos : Vector2i
var end_pos : Vector2i

func _draw():
	draw_rect(drawing_rect, hitbox_color)
	for box in boxes:
		draw_rect(box, hitbox_color)


func _input(event):
	var box_pos : Vector2i
	# we will have an array of boxes to use and 
	#	we check every frame to see if each of these boxes 
	#	has the position from the event
	var current_box_id : int
	var current_box_pos : Vector2i
	
	# Use InputEventMouseMotion for dragging
	#print(event)
	
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#if Rect2(0, 0, 30, 20).has_point(to_local((event.position))):
		#	drag_box = true
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
		#if Rect2(0, 0, 30, 20).has_point(to_local((event.position))):
		#	drag_box = false
		if get_rect().has_point(to_local(event.position)) and !drag_box:
			var local_event_position = to_local(event.position)
			dragging = false
			end_pos = local_event_position
			boxes.append(drawing_rect)
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
			if negx: new_area.position.x -= drawing_rect.size.x
			if negy: new_area.position.y -= drawing_rect.size.y
			var modx = drawing_rect.size.x % 2
			var mody = drawing_rect.size.y % 2
			new_area.position.x += modx / 2.0
			new_area.position.y += mody / 2.0
			print("size: ", drawing_rect.size)
			print("dpos: ", drawing_rect.position, " npos: ",drawing_rect.position + (halfsize))
			
	
	if dragging and event is InputEventMouseMotion:
		var local_event_position = to_local(event.position)
		end_pos = local_event_position
		drawing_rect = Rect2i(start_pos, end_pos - start_pos)
		#print(drawing_rect)
		queue_redraw()

class BoxArea:
	var rect : Rect2i
	var active : bool
