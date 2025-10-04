@tool extends Control

class BoxInfoPanelState:
	var active : bool
	var rect : Rect2i
	var type : String

signal state_changed(active: bool, rect: Rect2i, type: String)

var current_state : BoxInfoPanelState


func _ready() -> void:
	current_state = BoxInfoPanelState.new()
	$ColorRect.color = Color.RED
	set_state(true, Rect2i(10, 15, 23, 42), Rect2i(-48, -48, 96, 96), "hitbox")


func set_state(active: bool, rect: Rect2i, sprite_rect: Rect2i, type: String):
	current_state.active = active
	$VBoxContainer/HBoxContainer2/ActiveCheckbox.button_pressed = active
	current_state.rect = rect
	var rectposx = $VBoxContainer2/HBoxContainer/PosX
	var rectposy = $VBoxContainer2/HBoxContainer/PosY
	var rectsizex = $VBoxContainer2/HBoxContainer2/SizeX
	var rectsizey = $VBoxContainer2/HBoxContainer2/SizeY
	
	rectposx.min_value = sprite_rect.position.x - sprite_rect.size.x
	rectposx.max_value = sprite_rect.position.x + sprite_rect.size.x
	rectposy.min_value = sprite_rect.position.y - sprite_rect.size.y
	rectposy.max_value = sprite_rect.position.y + sprite_rect.size.y
	
	rectsizex.min_value = 0
	rectsizex.max_value = sprite_rect.size.x
	rectsizey.min_value = 0
	rectsizey.max_value = sprite_rect.size.y
	
	current_state.type = type
	$VBoxContainer/HBoxContainer/BoxType.text = "Hitbox" if type == "hitbox" else "Hurtbox"
	$VBoxContainer/HBoxContainer/CheckButton.button_pressed = false if type == "hitbox" else true 


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		current_state.type = "hurtbox"
		$VBoxContainer/HBoxContainer/BoxType.text = "Hurtbox"
		$ColorRect.color = Color.GREEN
	else:
		current_state.type = "hitbox"
		$VBoxContainer/HBoxContainer/BoxType.text = "Hitbox"
		$ColorRect.color = Color.RED
	
	state_changed.emit(current_state.active, current_state.rect, current_state.type)	


func _on_active_checkbox_toggled(toggled_on: bool) -> void:
	current_state.active = toggled_on


func _on_pos_x_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_pos_y_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_size_x_value_changed(value: float) -> void:
	pass # Replace with function body.


func _on_size_y_value_changed(value: float) -> void:
	pass # Replace with function body.
