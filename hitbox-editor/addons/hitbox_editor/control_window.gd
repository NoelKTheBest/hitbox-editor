@tool
extends Control

@onready var file_dialog: FileDialog = $FileDialog
@onready var item_list: ItemList = $MainContainer/VBoxContainer/ItemList
@onready var frame_selection: Sprite2D = $MainContainer/HBoxContainer/SpriteSheetControls/FrameSelection
@onready var line_edit: LineEdit = $MainContainer/VBoxContainer/HBoxContainer/LineEdit

var current_lib
var unsaved_msg = "*Unsaved Library"


func _on_load_pressed() -> void:
	#file_dialog = FileDialog.new()
	#file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	#file_dialog.access = FileDialog.ACCESS_RESOURCES
	file_dialog.add_filter("*.res, *.tres", "Animation Files and Libraries")
	file_dialog.visible = true
	#file_dialog.file_selected.connect(_on_file_selected)
	#add_child(file_dialog)


func _on_file_dialog_file_selected(path: String) -> void:
	var res = load(path)
	if res is AnimationLibrary:
		var anims = res.get_animation_list()
		var display_string : String = ""
	elif res is Animation:
		frame_selection.animations.append(res)
		frame_selection.animation_names.append(path)
		line_edit.placeholder_text = unsaved_msg
		item_list.add_item(path)
		
	
	
	#for anim in anims:
	#	if anim != "RESET":
	#		display_string = display_string + anim + '\n'
	#		item_list.add_item(anim)


func _on_visibility_changed() -> void:
	pass


func _on_item_list_item_activated(index: int) -> void:
	# Make main container invisible and make extra/ container visible
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	# Make extra container invisible and make main container visible
	pass # Replace with function body.
