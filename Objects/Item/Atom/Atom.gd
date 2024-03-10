class_name Atom extends Item

@export var atom : AtomT
var Atoms : Array[AtomT]

func _process(delta):
	if atom:
		Atoms = [atom]
		$Name.text = atom.Name
	shape_owner_get_shape(0,0).size = $Name.size

func _input(event):
	if event.is_action_released("click") && is_mouse_in:
		InputHandler.picked_up_item = self if InputHandler.picked_up_item != self else null
		is_picked_up = InputHandler.picked_up_item == self

func _on_mouse_entered():
	is_mouse_in = true
func _on_mouse_exited():
	is_mouse_in = false
