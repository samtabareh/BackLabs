class_name Divider extends Station

@onready var player : AnimationPlayer = $Sprite/Player
@onready var slot : Slot = $Slot

var newest : Item

func Action():
	var input : Item = slot.picked_up
	if input == null: return
	if input.Atoms.is_empty(): return
	
	in_use = true
	player.play("in")
	await player.animation_finished
	
	var recurrences := {}
	for atom in input.Atoms:
		if recurrences.get(atom) != null: continue
		recurrences[atom] = input.Atoms.count(atom)
	
	input.queue_free()
	var temp = load("res://Objects/Item/Atom/Atom.tscn")
	var first = temp.instantiate()
	add_sibling(first)
	
	first.global_position = slot.global_position
	first.Atoms.append(recurrences.keys()[0])
	recurrences[recurrences.keys()[0]] -= 1
	newest = first
	slot.pick_up(newest)
	
	player.play("out")
	await player.animation_finished
	
	for atom in recurrences.keys():
		for rec in range(recurrences[atom]):
			var deposit : Atom = temp.instantiate()
			add_sibling(deposit)
			deposit.global_position = newest.global_position
			deposit.Atoms = []
			deposit.Atoms.append(atom)
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
