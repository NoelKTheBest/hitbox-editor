@tool
extends Control

@onready var file_dialog: FileDialog = $FileDialog
@onready var item_list: ItemList = $MainContainer/VBoxContainer/ItemList
@onready var frame_selection: Sprite2D = $MainContainer/HBoxContainer/SpriteSheetControls/FrameSelection
@onready var line_edit: LineEdit = $MainContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var main_container: VBoxContainer = $MainContainer
@onready var extra_container: HBoxContainer = $ExtraContainer

var animated_character_scene = preload("res://addons/hitbox_editor/sample_scenes/AnimatedCharacter.tscn")
var animated_scene_instance

var current_lib
var unsaved_msg = "*Unsaved Library"


func _ready() -> void:
	print(get_tree().current_scene)


func _on_load_pressed() -> void:
	#file_dialog = FileDialog.new()
	#file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	#file_dialog.access = FileDialog.ACCESS_RESOURCES
	file_dialog.add_filter("*.res, *.tres", "Animation Files and Libraries")
	file_dialog.visible = true
	#file_dialog.file_selected.connect(_on_file_selected)
	#add_child(file_dialog)


func _on_file_dialog_file_selected(path: String) -> void:
	animated_scene_instance = animated_character_scene.instantiate()
	frame_selection.scene = animated_scene_instance
	#print(animated_scene_instance, frame_selection.scene)
	var res = load(path)
	if res is AnimationLibrary:
		var anims = res.get_animation_list() # returns a string array
		var display_string : String = ""
		for anim in anims:
			if anim != "RESET":
				display_string = display_string + anim + '\n'
				item_list.add_item(anim)
				frame_selection.animations.append(res.get_animation(anim))
				frame_selection.animation_names.append(anim)
		#print(frame_selection.animations)
	elif res is Animation:
		frame_selection.animations.append(res)
		frame_selection.animation_names.append(path)
		line_edit.placeholder_text = unsaved_msg
		item_list.add_item(path)
	
	for child in animated_scene_instance.get_children():
		if child is AnimationPlayer:
			print_rich("[color=orange]AnimationPlayer")
	
	print(animated_scene_instance.get_path_to(animated_scene_instance.get_child(1)))


func _on_visibility_changed() -> void:
	pass


func _on_item_list_item_activated(index: int) -> void:
	# Make main container invisible and make extra/ container visible
	var anim = frame_selection.animations[index]
	print(frame_selection.animations[index])
	if anim.find_track("Sprite2D:texture", Animation.TYPE_VALUE) == -1:
		print_rich("[color=yellow]This animation does not have a texture property")
	else: 
		print("Found texture property")
		main_container.visible = false
		extra_container.visible = true


func _on_exit_button_pressed() -> void:
	# Make extra container invisible and make main container visible
	extra_container.visible = false
	main_container.visible = true
