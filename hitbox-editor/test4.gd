extends Sprite2D

# For bigger spritesheets with both multiple hframes and vframes
#	Keep track of the current hframe and vframe dtermined by frame_coords 
var chf
var cvf


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chf = frame_coords.x
	cvf = frame_coords.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _draw():
	var t = Transform2D()
	t.x.x *= 2.0
	t.x.y *= 2.0
	#var ts = get_rect()
	var fr = get_rect()
	var cf = frame
	#var fs = ts.size / hframes
	fr.position.x = fr.size.x * frame
	fr.position.y
	
	var v = Vector2()
	var s = Vector2()
	#draw_set_transform(v, 0.0, s)
	draw_set_transform_matrix(t)
	draw_texture_rect_region(texture, get_rect(), fr)
	pass
