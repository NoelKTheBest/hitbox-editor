@tool
extends Control

@onready var file_dialog: FileDialog = $FileDialog
@onready var item_list: ItemList = $VBoxContainer/VBoxContainer/ItemList


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
	var anims = res.get_animation_list()
	var display_string : String = ""
	
	
	
	for anim in anims:
		if anim != "RESET":
			display_string = display_string + anim + '\n'
			item_list.add_item(anim)
	
	#rich_text_label.text = display_string


func get_mouse_input():
	pass
