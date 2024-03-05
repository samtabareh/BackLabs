class_name Slot extends Area2D

## Emitted when the slot has picked up an Item 
signal up

## If the slot is a result slot
@export var is_result_slot : bool = false
## The item that the slot has picked up
@export var picked_up : Item

## If slot can pick up Items
var can_pickup = true
## The items in the slots area that can be picked up
var in_range : Array
## Nearest item in the slot's in_range
var nearest : Item

func _process(delta):
	can_pickup = visible
	if is_result_slot:
		can_pickup = true
		visible = picked_up != null
		$Plus.visible = false
		return

	var check = false
	for node in get_children():
		if node != picked_up && node is Item:
			check = true
			put_down(node)
	if check: picked_up.reparent(self)
	
	if !in_range.is_empty():
		in_range.sort_custom(get_nearest)
		nearest = in_range[0]

		if !nearest.is_picked_up && !nearest.in_slot && can_pickup:
			if global_position != nearest.global_position:
				nearest.global_position = global_position
			if nearest != picked_up: pick_up(nearest)
	$Plus.visible = picked_up == null

func get_nearest(A : Item, B : Item):
	var distance_a = A.global_position.distance_to(global_position)
	var distance_b = B.global_position.distance_to(global_position)
	return distance_a < distance_b

func pick_up(item : Item):
	if item == null || item.in_slot: return
	
	item.in_slot = true
	item.reparent(self)
	item.global_position = global_position
	item.visible = true
	if picked_up != null: picked_up.in_slot = false
	picked_up = item
	up.emit()

func put_down(item : Item):
	item.in_slot = false
	item.reparent(get_tree().current_scene)
	if item == picked_up: picked_up = null

func _on_area_entered(area):
	var body = area.get_parent()
	if body is Item: in_range.append(body)

func _on_area_exited(area):
	var body = area.get_parent()
	if picked_up == body && body.is_picked_up:
		call_deferred("put_down", body)
	if in_range.has(body): in_range.erase(body)
