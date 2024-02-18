class_name Molecule extends Item

func _process(delta):
		$Name.text = Molecule.calculate_molecule_name(Atoms)
		shape_owner_get_shape(0,0).size = $Name.size

func _input(event):
	if event.is_action_released("click") && is_mouse_in:
		Main.picked_up_item = self if Main.picked_up_item != self else null
		picked_up = Main.picked_up_item == self

static func calculate_molecule_name(Atoms : Array[Enums.Atoms]) -> String:
	if not Atoms.is_empty():
		var recurrences := {}
		var ret := ""
		for atom in Atoms:
			if recurrences.get(atom) != null: continue
			recurrences[atom] = Atoms.count(atom)
			if recurrences[atom] > 1: ret += Enums.Atoms.keys()[atom]+str(recurrences[atom])
			else: ret += Enums.Atoms.keys()[atom]
		return ret
	else: return ""

func _on_mouse_entered():
	is_mouse_in = true

func _on_mouse_exited():
	is_mouse_in = false
