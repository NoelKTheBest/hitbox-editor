@tool
extends Sprite2D

@onready var hframes_select: SpinBox = $"../../Frame Selection/hframes_select"
@onready var vframes_select: SpinBox = $"../../Frame Selection/vframes_select"
@onready var frame_select: SpinBox = $"../frame_select"
@onready var collision_box: Sprite2D = $"../../../../CollisionBox"


var width
var height


func _ready() -> void:
	hframes_select.value_changed.connect(update_hframes)
	vframes_select.value_changed.connect(update_vframes)
	frame_select.value_changed.connect(update_frame)
	width = texture.get_width()
	height = texture.get_height()
	print("w: " + str(width) + "; h: " + str(height))
	print(get_rect())


func _draw() -> void:
	pass


func _on_save_pressed() -> void:
	var anim = Animation.new()
	var track_index = anim.add_track(Animation.TYPE_VALUE)
	anim.track_set_path(track_index, "Sprite2D:texture")
	anim.track_insert_key(track_index, 0.0, texture)
	anim.track_insert_key(track_index, 1.0, texture)
	anim.length = 1.0
	print(anim)
	ResourceSaver.save(anim, "res://testanim.tres")


func update_hframes(value: float):
	hframes = value
	print(get_rect())
	var rect_size = get_rect().size
	var texture_image = texture.get_image()
	texture_image.convert(Image.FORMAT_RGBA8)
	#var frame_selection
	var new_image = Image.create_empty(rect_size.x, rect_size.y, false, Image.FORMAT_RGBA8)
	new_image.blit_rect(texture_image, get_rect(), Vector2i(0, 0))
	
	var new_texture = ImageTexture.create_from_image(new_image)
	collision_box.texture = new_texture
	
	#frame_select.max_value = value - 1
	#frame_select.min_value = 0


func update_vframes(value: float):
	vframes = value
	print(get_rect())


func update_frame(value: float):
	frame = value
	
	#frame_coords = Vector2i(value, 0)


#func _texture_changed():
#	hframes_select.min_value = 0
