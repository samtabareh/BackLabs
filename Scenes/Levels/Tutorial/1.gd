extends Node2D

@onready var Display : DisplayText = $DisplayText

func _ready():
	await Display.text(["Tut1", "Tut2", "Tut3", "Tut4"])
	
	$Atom.visible = true
	await Display.text(["Tut11"])
	
	$Molecule.visible = true
	await Display.text(["Tut5","Tut6","Tut7"])
	
	$Slot.visible = true
	await Display.text(["Tut8"])
	
	$Infuser.visible = true
	await Display.text(["Tut9","Tut10", "Tut12"])
	
	$Divider.visible = true
	await Display.text(["Tut13"])
	
	$GoalScreen.visible = true
	await Display.text(["Tut14","Tut15","Tut16"])
