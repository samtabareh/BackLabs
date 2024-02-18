class_name Infuser extends Station

@onready var player : AnimationPlayer = $Sprite/Player
@onready var slots = $Slots.get_children()
@onready var rSlot = $ResultSlot

@onready var deposit : Item

func Action():
	var is_empty = true
	for slot in slots:
		if slot.picked_up != null: is_empty = false
	if is_empty: return
	
	in_use = true
	player.play("use")
	await player.animation_finished
	
	deposit = rSlot.picked_up
	if !deposit:
		var temp = load("res://Objects/Item/Molecule/Molecule.tscn")
		deposit = temp.instantiate()
		call_deferred("add_sibling", deposit)
		deposit.Atoms = []
	
	for slot in slots:
		if slot.picked_up == null: continue
		if slot.picked_up.Atoms.is_empty(): continue
		deposit.Atoms += slot.picked_up.Atoms
		slot.picked_up.queue_free()
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
