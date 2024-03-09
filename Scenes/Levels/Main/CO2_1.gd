extends Node2D

@onready var display: DisplayText = $DisplayText

func _ready():
	await display.text(["Main_CO2_1-1", "Main_CO2_1-2", "Main_CO2_1-3"])
