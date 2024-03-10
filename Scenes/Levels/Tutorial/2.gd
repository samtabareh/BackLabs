extends Node2D

@onready var display : DisplayText = $DisplayText

func _ready():
	await display.text(["Tutorial_2-1", "Tutorial_2-2", "Tutorial_2-3", "Tutorial_2-4"])
	$Infuser.visible = true
	$GoalScreen.visible = true
	$CO2.visible = true
	$H2.visible = true
