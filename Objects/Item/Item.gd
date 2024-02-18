class_name Item extends Interactable

var picked_up = false
var in_slot = false
## Sets the objects texture to this resource, it doesnt change in the editor in real time sadly.
## The resource has no effect if the object is not an Item.
@export var texture : Texture2D
## The atoms of the object.
@export var Atoms : Array[Enums.Atoms] = []

func _process(delta):
	$Sprite2D.texture = texture
	var tooltip = Molecule.calculate_molecule_name(Atoms)
	if $Tooltip.tooltip_text != tooltip:
		$Tooltip.tooltip_text = tooltip

func _input(event):
	if event.is_action_released("click") && is_mouse_in:
		Main.picked_up_item = self if Main.picked_up_item != self else null
		picked_up = Main.picked_up_item == self

func _on_mouse_entered():
	is_mouse_in = true

func _on_mouse_exited():
	is_mouse_in = false
