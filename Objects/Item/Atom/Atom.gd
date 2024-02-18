class_name Atom extends Item

func _process(delta):
	$Name.text = Enums.Atoms.keys()[Atoms[0]]
	shape_owner_get_shape(0,0).size = $Name.size

func _input(event):
	if event.is_action_released("click") && is_mouse_in:
		Main.picked_up_item = self if Main.picked_up_item != self else null
		picked_up = Main.picked_up_item == self

static func calculate_atom_name(Atoms : Array[Enums.Atoms]) -> String:
	if not Atoms.is_empty():
		var main_atom = Atoms[0]
		var recurrences := 0
		for atom in Atoms:
			if not atom == main_atom: Atoms.remove_at(Atoms.find(atom))
			else: recurrences += 1
		var ret = Enums.Atoms.keys()[main_atom]
		if recurrences > 1: ret += str(recurrences)
		return ret
	else: return ""

func _on_mouse_entered():
	is_mouse_in = true
func _on_mouse_exited():
	is_mouse_in = false
