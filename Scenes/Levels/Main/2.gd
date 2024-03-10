extends Node2D

@onready var display : DisplayText = $DisplayText

func _ready():
	await display.text(["Main_2-1", "Main_2-2"])
