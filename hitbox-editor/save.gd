@tool extends EditorScript

func _run() -> void:
	ProjectSettings.set("canvas_textures/default_texture_filter", "Nearest")
	ProjectSettings.save()
	print("testing")
