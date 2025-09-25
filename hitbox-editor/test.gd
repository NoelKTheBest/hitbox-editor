extends Sprite2D


var frame_size : Vector2i
@onready var editor_sprite: Sprite2D = $Sprite2D2
@onready var texture_display: Sprite2D = $Sprite2D



func _ready() -> void:
	editor_sprite.texture = texture
	editor_sprite.hframes = hframes
	editor_sprite.vframes = vframes
	editor_sprite.frame = frame
	
	texture_display.texture = texture
	#texture_display.hf = hframes
	#texture_display.vf = vframes
	

	frame = 4


func _draw() -> void:
	var texture_rect = get_rect()
	draw_rect(texture_rect, Color(1, 1, 1, 0.3))
	
	var image = texture.get_image()
	var frame_pos_x : int
	var frame_pos_y : int
	var frame_position : Vector2i
	var frame_rect = Rect2(texture_rect.position.x + texture_rect.position.x + (texture_rect.size.x * frame), texture_rect.position.y, texture_rect.size.x, texture_rect.size.y)
	#print(frame_rect)
	#print(texture_rect)
	draw_texture_rect_region(texture,texture_rect, frame_rect)
	
