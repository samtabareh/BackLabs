@tool
class_name AtomDisplay extends Label

@export var Atoms : Array[Enums.Atoms] = []

func _process(delta):
	text = Molecule.calculate_molecule_name(Atoms)
