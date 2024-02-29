class_name Molecule extends Item

# Short for MoleculeT
@export var molecule : MoleculeT
var Atoms : Array[AtomT]

func _process(delta):
	if molecule:
		Atoms = molecule.Atoms
		$Name.text = molecule.Name
	shape_owner_get_shape(0,0).size = $Name.size

static func count_molecules(a : Array[AtomT]) -> Dictionary:
	if a.is_empty(): pass
	var rec = {}
	for atom in a:
		if rec.get(atom) != null: continue
		rec[atom] = a.count(atom)
	return rec

static func compare_molecules(array1, array2):
	if array1.size() != array2.size(): return false
	for item in array1:
		if !array2.has(item): return false
		if array1.count(item) != array2.count(item): return false
	return true

func _input(event):
	if event.is_action_released("click") && is_mouse_in:
		Main.picked_up_item = self if Main.picked_up_item != self else null
		is_picked_up = Main.picked_up_item == self

func _on_mouse_entered():
	is_mouse_in = true

func _on_mouse_exited():
	is_mouse_in = false
