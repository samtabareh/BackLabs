extends Main

signal clicked

var picked_up_item : Item
var id = "PickupHandler"

func _input(event):
	if Input.is_action_just_pressed("click"): clicked.emit()
	if event is InputEventMouseMotion && picked_up_item:
		picked_up_item.global_position = picked_up_item.get_global_mouse_position()
