extends Sprite2D


var frame_size : Vector2i
var frame_positions = []
@onready var sprite_2d_2: Sprite2D = $Sprite2D2


func _ready() -> void:
	sprite_2d_2.texture = texture
	sprite_2d_2.hframes = hframes
	sprite_2d_2.vframes = vframes
	sprite_2d_2.frame = frame
	frame_size = texture.get_size()
	frame_size.x = frame_size.x / hframes
	frame_size.y = frame_size.y / vframes
	print(frame_size)
	frame_positions.append(Vector2i(0, 0))
	for i in range(hframes):
		var x = frame_size.x * i
		frame_positions.append(Vector2i(x, 0))
		print(Vector2i(x, 0))
	frame = 4


func _draw() -> void:
	var texture_rect = get_rect()
	draw_rect(texture_rect, Color(1, 1, 1, 0.3))
	
	var image = texture.get_image()
	var frame_pos_x : int
	var frame_pos_y : int
	var frame_position : Vector2i
	var frame_rect = Rect2(texture_rect.position.x + texture_rect.position.x + (texture_rect.size.x * frame), texture_rect.position.y, texture_rect.size.x, texture_rect.size.y)
	print(frame_rect)
	print(texture_rect)
	draw_texture_rect_region(texture,texture_rect, frame_rect)
	
