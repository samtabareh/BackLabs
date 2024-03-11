extends Node2D

@onready var Display : DisplayText = $DisplayText

func _ready():
	await Display.text(["Tutorial_1-1", "Tutorial_1-2", "Tutorial_1-3", "Tutorial_1-4"])
	
	$O.visible = true
	await Display.text(["Tutorial_1-5"])
	
	$H2.visible = true
	await Display.text(["Tutorial_1-6","Tutorial_1-7","Tutorial_1-8"])
	
	$Slot.visible = true
	await Display.text(["Tutorial_1-9"])
	
	$Infuser.visible = true
	await Display.text(["Tutorial_1-10","Tutorial_1-11","Tutorial_1-12"])
	
	$GoalScreen.visible = true
	await Display.text(["Tutorial_1-13","Tutorial_1-14","Tutorial_1-15"])
