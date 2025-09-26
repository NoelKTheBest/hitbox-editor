extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _draw():
	var t = Transform2D()
	
	
	var v = Vector2()
	var s = Vector2()
	#draw_set_transform(v, 0.0, s)
	draw_set_transform_matrix(t)
	pass
