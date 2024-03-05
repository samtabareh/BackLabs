class_name Infuser extends Station

@onready var player : AnimationPlayer = $Sprite/Player
@onready var slots = $Slots.get_children()
@onready var rSlot = $ResultSlot

@onready var deposit : Molecule

func Action():
	var is_empty = true
	for slot in slots:
		if slot.picked_up != null: is_empty = false
	if is_empty: return
	
	# Gather all atoms from slots.
	var Atoms : Array[AtomT] = []
	for slot in slots:
		if slot.picked_up == null: continue
		if slot.picked_up.Atoms.is_empty(): continue
		Atoms += slot.picked_up.Atoms
	
	# See what molecule matches our current one.
	var check = false
	for molecule in TypesLoader.Molecules:
		var m = TypesLoader.Molecules[molecule]
		deposit = rSlot.picked_up
		
		if deposit: check = Molecule.compare_molecules(Atoms+deposit.Atoms, m.Atoms)
		else: check = Molecule.compare_molecules(Atoms, m.Atoms)
		
		if check:
			in_use = true
			player.play("use")
			await player.animation_finished
			if !deposit:
				var temp = load("res://Objects/Item/Molecule/Molecule.tscn")
				deposit = temp.instantiate()
				call_deferred("add_sibling", deposit)
			
			deposit.molecule = m
			for slot in slots:
				if slot.picked_up == null: continue
				slot.picked_up.queue_free()
			break
	if !check:
		for node in get_parent().get_children():
			if node is DisplayText:
				node.text(["NoneMolecule"])
		return
	
	rSlot.put_down(deposit)
	rSlot.pick_up(deposit)
	player.play("default")
	in_use = false

func _input(event):
	if is_mouse_in:
		if event.is_action_released("rclick") && !in_use:
			Action()

func _on_mouse_entered():
	is_mouse_in = true
func _on_mouse_exited():
	is_mouse_in = false
