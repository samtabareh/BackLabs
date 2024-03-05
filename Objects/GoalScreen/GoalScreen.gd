class_name GoalScreen extends Node

@onready var sprite : Sprite2D = $Sprite
@onready var player : AnimationPlayer = $Sprite/Player
@onready var slots : Array[Slot] = [$Slot1, $Slot2, $Slot3]

## Amount of inputs that the screen will take in.
@export_range(1, 3) var Inputs : int = 1
@export var molecule : MoleculeT = TypesLoader.Molecules["H2O"]
@export var Result_Scene : PackedScene

# Slots that are being used. (based on inputs)
var on_slots : Array[Slot]
# A boolean to prevent the animations playing in a loop.
var play_anim = true

func _ready():
	for s in slots:
		s.visible = false
	var a = "%s" % Inputs
	player.play(a)
	
	for i in range(Inputs):
		slots[i].visible = true
		on_slots.insert(0, slots[i])

func _process(delta):
	# Reset scale property
	$AtomDisplay.size = Vector2(0,0)
	sprite.scale.x = 2 + Inputs
	
	$AtomDisplay.text = molecule.Name
	# Positioning
	$AtomDisplay.position.x = sprite.texture.get_width()*sprite.scale.x / 7 - $AtomDisplay.size.x
	$Equal.position.x = $AtomDisplay.position.x - 15
	
	if molecule.Atoms.size() > 1: $Equal.position.x -= $AtomDisplay.size.x/molecule.Atoms.size()
	else: $Equal.position.x -= $AtomDisplay.size.x
	
	# Checking to see if any of the used slots are empty.
	var check = false
	for s in on_slots:
		if s.picked_up == null: check = true
	if check: return
	
	# Gather all atoms from the used slots.
	var Atoms : Array[AtomT] = []
	for s in on_slots: 
		Atoms += s.picked_up.Atoms
	
	if play_anim:
		if Molecule.compare_molecules(Atoms, molecule.Atoms): win()
		else:
			player.play("wrong")
			play_anim = false

func win():
	player.play("win")
	play_anim = false
	var node1 : DisplayText
	for node in get_parent().get_children():
		if node is DisplayText:
			node1 = node
			await node1.text(["Win"])
	if Result_Scene != null: LevelHandler.change_level(Result_Scene.resource_path)
	else: LevelHandler.change_level(LevelHandler.next_level())

func _on_slot_up():
	play_anim = true
