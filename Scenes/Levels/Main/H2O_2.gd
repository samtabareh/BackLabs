extends Node2D

@onready var display : DisplayText = $DisplayText

func _ready():
	await display.text(["Main_H2O_2-1", "Main_H2O_2-2"])
