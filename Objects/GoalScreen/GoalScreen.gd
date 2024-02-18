@tool
class_name GoalScreen extends Node

@onready var sprite : Sprite2D = $Sprite
@onready var player : AnimationPlayer = $Sprite/Player
@onready var slots : Array[Slot] = [$Slot1, $Slot2, $Slot3]

@export_range(1, 3) var Inputs : int = 1
@export var Atoms : Array[Enums.Atoms]
@export var Result_Scene : PackedScene

var pos : Array[Slot]
var play_anim = true

func _ready():
	for s in slots:
		s.visible = false
	var a = "%s" % Inputs
	player.play(a)
	
	for i in range(Inputs):
		slots[i].visible = true
		pos.insert(0, slots[i])

func _process(delta):
	$AtomDisplay.size = Vector2(0,0)
	sprite.scale.x = 2 + Inputs
	
	$AtomDisplay.Atoms = Atoms
	$AtomDisplay.position.x = sprite.texture.get_width()*sprite.scale.x / 7 - $AtomDisplay.size.x
	$Equal.position.x = $AtomDisplay.position.x - 15
	if Atoms.size() > 1: $Equal.position.x -= $AtomDisplay.size.x/Atoms.size()
	else: $Equal.position.x -= $AtomDisplay.size.x
	
	var temp = false
	for s in pos:
		if s.picked_up == null: temp = true
	if temp: return
	
	var IAtoms : Array[Enums.Atoms] = []
	for s in pos: 
		IAtoms += s.picked_up.Atoms
	if play_anim:
		if IAtoms == Atoms: win()
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
			await node1.text(["You won!"])
	if Result_Scene != null: LevelHandler.change_level(Result_Scene.resource_path)
	else: LevelHandler.change_level(LevelHandler.next_level())

func _on_slot_up():
	play_anim = true
