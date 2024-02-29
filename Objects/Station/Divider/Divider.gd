class_name Divider extends Station

## The animation player for the divider.
@onready var player : AnimationPlayer = $Sprite/Player
## The only slot that the divider has and uses to function.
@onready var slot : Slot = $Slot

## Newest created atom.
var newest : Item

func Action():
	var input : Item = slot.picked_up
	if input == null: return
	if input.Atoms.is_empty(): return
	
	in_use = true
	player.play("in")
	await player.animation_finished
	
	# Count how many atoms of the same type there are in the Item.
	var recurrences = Molecule.count_molecules(input.Atoms)
	
	input.queue_free()
	var temp = load("res://Objects/Item/Atom/Atom.tscn")
	var first : Atom = temp.instantiate()
	add_sibling(first)
	
	first.global_position = slot.global_position
	# Set the atom of the first item as the first recurring atom.
	first.atom = recurrences.keys()[0]
	# Decrement the first atoms recurrents int, because we made one of the atoms.
	recurrences[recurrences.keys()[0]] -= 1
	newest = first
	slot.pick_up(newest)
	
	player.play("out")
	await player.animation_finished
	
	for atom in recurrences.keys():
		for rec in range(recurrences[atom]):
			var deposit : Atom = temp.instantiate()
			add_sibling(deposit)
			deposit.atom = atom
			deposit.global_position = newest.global_position
			# set the y of the atom to be right above the newest atom.
			deposit.global_position.y -= newest.shape_owner_get_shape(0,0).size.y + 4
			newest = deposit
	in_use = false

func _input(event):
	if is_mouse_in:
		if event.is_action_released("rclick") && !in_use:
			Action()

func _on_mouse_entered():
	is_mouse_in = true
func _on_mouse_exited():
	is_mouse_in = false
