extends Main

signal clicked

var picked_up_item : Item
var id = "InputHandler"

func _input(event):
	if Input.is_action_just_released("click"): clicked.emit()
	
	if event is InputEventMouseMotion && picked_up_item:
		picked_up_item.global_position = picked_up_item.get_global_mouse_position()
	
	if Input.is_action_just_released("dev"):
		Main.is_dev = !Main.is_dev
		push_warning("is_dev: ", Main.is_dev)
